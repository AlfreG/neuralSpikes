function [mc,f,w,w2] = markovchain(G,L,start,pjump)
% mc = markovchain(G,L) return a Markov chain of L steps over the (possibly
% directed and link-weighted) graph G, starting from a randomly chosen node;
% mc = markovchain(G,L,start) does the same starting from start, which
% can be the index or the name of a given node.
% When only 2 or 3 inputs are given, the chains stops at dead ends (nodes
% without any out-link) regardless of the requested length L.
% mc = markovchain(G,L,start,mode) change the above default behaviour as
% follows:
%   1. if pjump = -1, the chain loops indefinitely at dead ends;
%   2. if pjump is a numerical scalar and 0 <= pjump <= 1, a jump to a 
%      randomly chosen node is made with probability pjump from non 
%      dead-end nodes and with probability 1 from dead-end nodes;
%      N.B.: with probability 1/G.numnodes no jump is really made.
% [mc,f] = markovchain(...) returns also the node visit frequency.
% [mc,f,w] = markovchain(...) returns also the transition frequency.
% [mc,f,w,w2] = markovchain(...) returns also the double transition 
% frequency, which should verify w2_jkr = w_jk*w_kr.


narginchk(2,4);
if ~isa(G,'digraph') && ~isa(G,'graph')
    error('First input must be a graph or a digraph')
end
n = G.numnodes;

if nargin >= 3
    if round(start) ~= start
        error('the starting node in third input must be a scalar integer')
    else
        start = G.findnode(start);
        if start < 1 || start > n
            error('starting node not found')
        end
    end
else
    start = randi(n);
end

if nargin < 4
    pjump = -2; % conventional value to stop
elseif isnumeric(pjump) && isscalar(pjump)
    if pjump > 1 || (pjump < 0 && pjump ~= -1)
        error('fourth input must be -1 or a probability')
    end
else
    error('fourth input must be a numerical scalar')
end

if isa(G,'graph')
    G = digraph(G.adjacency);
end
startnode = G.findnode(G.Edges.EndNodes(:,1));
endnode = G.findnode(G.Edges.EndNodes(:,2)); 
try 
    weight = G.Edges.Weight;
catch
    weight = ones(G.numedges,1);
end
    
buf.n = ceil(L/n);
buf.y = zeros(buf.n,n);
buf.k = zeros(1,n);

% build the chain
mc = zeros(L+1,1);
mc(1) = start;
for j = 1:L
    node = mc(j);
    if buf.k(node) ==  0
        % (re)fill the buffer
        up = weight(startnode == node); % un-normalized probabilities
        if ~isempty(up)
            if all(weight) == weight(1)
                buf.y(:,node) = randi(length(up),buf.n,1);
            else
                x = metropolis(buf.n,up);
                buf.y(:,node) = x;
                %buf.y(:,node) = x(randperm(buf.n));
            end
        end
        buf.k(node) = buf.n;
    end
    next = buf.y(buf.k(node),node);
    if next == 0  % node is a dead end
        if pjump == -2
            break
        elseif pjump == -1
            mc(j+1) = node;
        else
            mc(j+1) = randi(n);
        end
    elseif pjump > 0 && rand(1) < pjump
        mc(j+1) = randi(n);
    else
        neighbors = endnode(startnode == node);
        % same as: 
        %neighbors = G.successors(node);
        % but much faster
        mc(j+1) = neighbors(next);
        buf.k(node) = buf.k(node) - 1;
    end
end

mc = mc(mc > 0); % to remove unused slots
L = length(mc);

if nargout > 1
    I = zeros(L,n);
    f = zeros(n,1);
    for j = 1:n
        I(:,j) = mc==j;
        f(j) = nnz(I(:,j));
    end
    % this is shorter, but we might use I below 
    %f = histcounts(mc,1/2:1:n+1/2)';
    f = f/L;
end

if nargout > 2
    w = zeros(n,n);
    for j = 1:n
        for k = 1:n
            w(j,k) = nnz(I(2:end,j) & I(1:end-1,k))/(L*f(k));
        end
    end
end

if nargout > 3
    w2 = zeros(n,n,n);
    for j = 1:n
        for k = 1:n
            for r = 1:n
                w2(j,k,r) = nnz(I(3:end,j) & I(2:end-1,k) & I(1:end-2,r))/(L*f(r));
            end
        end
    end
end