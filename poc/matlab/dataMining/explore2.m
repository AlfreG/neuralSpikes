p = param;
p.highFrequency = 2500;
p.lowFrequency  =  1;

% Normalize data
% data = data - mean(data,3);
% data = data ./ std(data, [], 3);

% Low Pass filter
[B, A] = butter(p.filterOrder, 2*p.highFreq/p.sampleRate, 'low');
x = filter( B, A, data, [], 3 );
% High Pass filter
[B, A] = butter(p.filterOrder, 2*p.lowFreq/p.sampleRate, 'high');
x = filter( B, A, data, [], 3 );
%     check1 = plot( reshape(x(1:3,1:3,:),9, 4000)' );
    

% Pixel's correlation
y = reshape(x, 32*32, 4000);
y = y';
corr = triu(corrcoef( y ));
corr = corr - eye( size(corr,1) );


% Undirected Graph
L = size(x,1);
i = reshape(repmat((1:L*L)',1,8)', 1, 8*L*L);
j = reshape(repmat([-1 +1 -L +L +L+1 -L-1 +L+2 -L-2],1,L*L)', 1, L*L*8);
j = i+j;
i = i(j>0 & j <= L*L);
j = j(j>0 & j <= L*L);
n = size(j,2);
A = sparse(i,j,corr(i, j),L*L,L*L,n);
g = graph(A);

