function rwalkongraph(G,pjump,mylayout)
% rwalkongraph(G,pjump) performs a graphical random walk on the graph G
% moving according to markovchain(G,inf,randi(G.numnodes),pjump);
% rwalkongraph(G) defaults to rwalkongraph(G,0);
% rwalkongraph(G,pjump,mylayout) fixes to mylayout the plotting layout;
% rwalkongraph(G,mylayout) defaults to rwalkongraph(G,0,mylayout).

narginchk(1,3);
if ~isa(G,'digraph') && ~isa(G,'graph')
    error('First input must be a graph or a digraph')
end
if nargin < 2
    pjump = 0;
elseif isnumeric(pjump) && isscalar(pjump)
    if pjump > 1 || (pjump < 0 && pjump ~= -1)
        error('second input must be -1 or a probability')
    end
else
    error('second input must be a numerical scalar')
end

if nargin < 3
    mylayout = 'layered';
    if ischar(pjump)
        mylayout = pjump;
    end
elseif ~ischar(mylayout)
    error('third input must be a string')
end

small = 4;
big = 6;
thin = 0.5;
thick = 1;
shg
clf
set(gcf,'color','white', 'numbertitle','off', 'name','Random walk on graph')

hG = plot(G,'NodeColor','k','EdgeColor','b','Layout',mylayout);
set(gca,'xtick',[],'ytick',[])
if isa(G,'digraph') && G.numnodes < 32; 
    hG.ArrowSize = 8;
end
hG.NodeLabel = zeros(1,G.numnodes);
hG.MarkerSize = small*ones(1,G.numnodes);
hG.LineWidth = thin*ones(1,G.numedges);

uicontrol('style','push','string','step','fontsize',10,'fontweight','bold',...
   'back','w','units','normalized','pos',[0.32 0.05 0.1 0.05], ...
   'callback', @fstep);
run = uicontrol('style','toggle','string','start','fontsize',10,'fontweight','bold',... ...
   'back','w','units','normalized','pos',[0.44 0.05 0.12 0.05], ...
   'callback', @frun);
quit = uicontrol('style','toggle','string','quit','fontsize',10,'fontweight','bold',...
   'back','w','units','normalized','pos',[0.58 0.05 0.1 0.05]);
drawnow

nbuf = 1e3;
mc = markovchain(G,nbuf,randi(G.numnodes),pjump);
jbuf = 1;
hG.NodeLabel{mc(jbuf)} = '1';
hG.highlight(mc(jbuf),'NodeColor','r')
hG.MarkerSize(mc(jbuf)) = big;

while ~quit.Value
    if run.Value
        fstep(0,0)
    end
    pause(0.2)
end
close(gcf);

    function fstep(~,~)
        s = mc(jbuf);
        jbuf = jbuf+1;
        t = mc(jbuf);
        e = G.findedge(s,t);
        if e 
            hG.highlight([s t],'EdgeColor','r')
            hG.LineWidth(e) = thick;
        else
            hl = line(hG.XData([s t]),hG.YData([s t]),...
               'linestyle','--','linewidth',1,'color','m');
        end
        pause(0.1)
        hG.highlight(s,'NodeColor','k')
        hG.MarkerSize(s) = small;
        pause(0.1)
        hG.highlight(t,'NodeColor','r')
        hG.MarkerSize(t) = big;
        pause(0.1)
        if e
            hG.LineWidth(e) = thin;
            hG.highlight([s t],'EdgeColor','b')
        else
            hl.delete
        end
        hG.NodeLabel{t} = num2str(str2double(hG.NodeLabel{t})+1);
    end

    function frun(h,~)
        if h.Value
            h.String = 'pause';
            if jbuf > nbuf
               mc = markovchain(G,nbuf);
               jbuf = 1;
            end
        else
            h.String = 'resume';
        end
    end
end
