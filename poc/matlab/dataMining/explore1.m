% Load parameters structures
p = param;
u = units;
s = graphSorting;
    s.path = '/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/dataMining/';


% Set param
p.saveGraph     = false;
p.sampleRate    = 9*1e3;
p.lowFreq       = 50;
p.highFreq      = 2500;
p.filterOrder   = 4;

% Choose analysis' profile
timeSeries  = 0;
histo       = 0;
svdAnalysis = 0;
filtering   = 0;
pixel       = 0;


% Starting filter
% [B, A] = butter(p.filterOrder, 2*[p.lowFreq p.highFreq]/p.sampleRate);
[B, A] = butter(p.filterOrder, 2*p.highFreq/p.sampleRate, 'low');
hFilter = fvtool(B,A);
x = filter( B, A, data, [], 3 );


% Cut first 100 obs: outliers
CUT = 1;
x = x( :, :, CUT:end );


% New sample size
N  = size(x,3);
Rx = size(x,1);
Ry = size(x,2);


% Discrete frequencies
freq    = ( -N/2 : 1 : N/2-1 ) * p.sampleRate / N;
freqMax =  N/2 * p.sampleRate / N;


% Extreme power pixels
[minPP, maxPP] = powerMap( x, s, false );


% Rectangular cluster
d = 1;
MRx = maxPP(1)-d:1:maxPP(1)+d;
MRy = maxPP(2)-d:1:maxPP(2)+d;

mRx = max(minPP(1)-d, 1):1:min(minPP(1)+d, Rx);
mRy = max(minPP(2)-d, 1):1:min(minPP(2)+d, Ry);


%
q1 = p;
q2 = p
q3 = p;
q4 = p;

y = x( :, :, :);
y = mean(y, [1 2]);
y = (y - mean(y,3)) / std(y,[],3);
y = reshape(y, 1, N);
q1 = ID(y, q1);

y = x( :, :, :);
y = std(y, [], [1 2]);
y = (y - mean(y,3)) / std(y,[],3);
y = reshape(y, 1, N);
q2 = ID(y, q2);


y = x( maxPP(1), maxPP(2), :);
y = mean(y, [1 2]);
y = (y - mean(y,3)) / std(y,[],3);
y = reshape(y, 1, N);
q3 = ID(y, q3);

y = x( mRx, mRy, :);
y = mean(y, [1 2]);
y = (y - mean(y,3)) / std(y,[],3);
y = reshape(y, 1, N);
q4 = ID(y, q4);

% plot( freq, q1.dft, '.' ); hold on;
% plot( freq, q2.dft, '.' ); hold on;
plot( freq, q3.dft, '.' ); hold on;
plot( freq, q4.dft, '.' ); hold on;
xlim([0, freqMax]);






%-------------------------------------------------------------------------
if svdAnalysis == true
    
    clc
    
    % Focus to cluster
    x = x(Ix, Iy, :);
        Rx = length(Ix);
        Ry = length(Iy);

    
    % Column wise sampled signal
    x = reshape( x, Rx*Ry, N );
    
    % Normalization
    x = ( x - mean(x,2) ) ./ std(x, [], 2);
    
    % SVD decomposition
    [u,s,v] = svd(x',0);     % economy size 
        sigma = diag(s);
%         semilogy(sigma,'.');
        
    y = [ sigma(1)*u(:,1) + sigma(2)*u(:,2)];
    svMax = 35;
    y  = u(:,1:svMax) * s(1:svMax, 1:svMax);
    y = y';
    
    p = ID( y, p);
    q = ID( x, p);
    
        plot( freq, p.dft(2,:) ); hold on;
        plot( freq, q.dft(:,:) );
        xlim( [0 freqMax] );

end





%--------------------------------------------------------------------------
if timeSeries == true
    
    % Focus to cluster
    x = x(Ix, Iy, :);
        Rx = length(Ix);
        Ry = length(Iy);
        p.pixelNumber = Rx*Ry;
        
    x = reshape( x, Rx*Ry, N );
    L = max(abs(x));
    y = filterPCA(x, p);
    
%     plot( x' ); hold on;
    plot(y')
    

    if p.saveGraph == true
        saveas( gcf, [path 'histo'], s.xts );
        close;
    end

end






if histo == true
    
    % Focus to cluster
    x = x(Ix, Iy, :);
        Rx = length(Ix);
        Ry = length(Iy);
        p.pixelNumber = Rx*Ry;
    
    x0 = reshape( x, Rx*Ry, N );
        sigma = std(x0);
        L = max(abs(x0));
    
    x1 = filterSIM(x0, p);
    x2 = filterPCA(x0, p) / mean(sigma);
    
    
    hold on;
    histogram( x0, 'Normalization', 'pdf' );
    histogram( x1, 'Normalization', 'pdf' );
    histogram( x2, 'Normalization', 'pdf' );
    
    x0 = reshape( x0, 1, Rx*Ry*N );
    plot(-L:L, normpdf(-L:L, mean(x0), std(x0) ), 'LineWidth', 1.5 );
    plot(-L:L, normpdf(-L:L, mean(x1), std(x1) ), 'LineWidth', 1.5 );
    plot(-L:L, normpdf(-L:L, mean(x2), std(x2) ), 'LineWidth', 1.5 );
   
    title( [ 'Histo full. Mean: ' num2str(mean(x0)) ' . Std: ' num2str(std(x0)) ] );
        

    K = 50;
    x0 = reshape( x0, Rx*Ry, N );

%     [x0, Jx0] = maxk(abs(x0), K);
    [Mx1, Jx1 ] = maxk(abs( x1 ), K);
    [Mx2, Jx2 ] = maxk(abs( x2 ), K);
    
    
    hold off;
    spikes = exp( -(( (1:N) - [Jx1'; Jx2'] )/10 ).^2 );
    spikes = sum(spikes, 1);
    ind1   = zeros(1,N);
    ind1(Jx1) = 0.5;
    
    plot(1:N, spikes ); hold on;
    plot(ind1);
%     line([0 N], [0 N], 'Color', 'k');
%     plot(Jz - Jy, '*'); hold on;

    Jx1 = sort(Jx1);
    Jx2 = sort(Jx2);
    
%     o = 1;
%     f1 = mink(Jx1,o)
%     f2 = mink(Jx2,o)
%     w1 = f1-5:f1+5;
%     w2 = f2-5:f2+5;
%     w = w1;
%     w = 424-5:424+5;
% %     w = 967-5:967+5;
%     subplot(3,1,1),     plot( w, x0(:,w) );
%     subplot(3,1,2),     plot( w, x1(:,w) );
%     subplot(3,1,3),     plot( w, x2(:,w) );
 
    if p.saveGraph == true
        saveas( gcf, [path 'histo'], s.xts );
        close;
    end

end






%--------------------------------------------------------------------------
if filtering == true
    
    % Load data
    pixel   = data(16,10,:);
    average = sum(data, [1 2]) / 32 / 32;
    
    pixel   = reshape( pixel , 1, 4000 );
    average = reshape( average, 1, 4000 );
    
    % Filter and graph
    graphExplorePSD( pixel, [], p, u, s, 30)
    
    saveas( gcf, [path 'average'], s.xts );
%     close;

end
 




%--------------------------------------------------------------------------
if pixel == true
    
    tick = 1:1:4000;
    n = 20;
    x = x( 1:n, 1:n, : );
    x = reshape(x, n*n, 4000);
    plot(tick, x )
    
%     saveas( gcf, [path 'pixel'], s.xts );
%     close;

end




%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [minPP, maxPP] = powerMap( data, s, plotTF )

data = data - mean(data,3);
sigma = std(data, [], 3);

[m,y] = min(sigma, [], 1);
[m,x] = min( m );
minPP = [ y(x), x ];

[M,y] = max(sigma, [], 1);
[M,x] = max( M );
maxPP = [ y(x), x ];

if plotTF == true
    H = histogram( sigma, 'Normalization', 'pdf' ); hold on;
    plot( [m M], [0 0], '*r' );
%     p = H.BinCounts/sum(H.BinCounts);
%     p = p(p>0);
%     entr = -sum(p.*log(p))/length(p)

    saveas( gcf, [s.path 'powerSpatialDensity'] );
    close;
end

end
