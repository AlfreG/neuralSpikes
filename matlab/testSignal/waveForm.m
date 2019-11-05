function impulse = impulseForm( p, rows, plotTF )
% Impulses 

if nargin==0
    p.saveGraph = false;
    plotTF = true;
    p.impulseType = 'gaussian';
    p.amplitudeHighFreq = 60*1e-3;      % V
    p.spikePeriod = 1e-3;               % s
    p.sampleRate  =  9*1e4;              % Hz
    rows = 1;                           % pixels
end

V = p.amplitudeHighFreq;
A = ( p.spikePeriod * p.sampleRate ) * sqrt(2) / 3 / 2;
b = round( A * sqrt( pi / 2 ) );
halfb = floor(b/2);
% T = p.sampleDuration;
T = p.spikePeriod;
halfN = ceil( T * p.sampleRate / 2 );
N = 2 * halfN;
t = ones(rows, N) .* linspace( 1, N, N);

phase = (2*rand(rows,1)-1);


switch p.impulseType
    
    case 'rectangular'
        impulse = zeros( rows, N );
        for j = 1: rows
            impulse( j, halfN + ceil(phase(j)) - halfb : halfN + halfb  ) = V;
        end
        
    case 'gaussian'
        impulse = V * exp( -( ( t - halfN - phase )/A).^ 2  );
        
    case 'gaussianPhased'
        impulse = V * exp( -( ( t - halfN - phase )/A).^ 2  );
        impulse = impulse .* (-1).^(1:1:N);

    case 'cozy'
        impulse = V * exp( -( ( t - halfN - phase )/(A)).^ 2  );
        impulse = impulse - 0.3 * V * exp( -( ( t -halfN - phase - A*sqrt(2) )/(A/sqrt(2))).^ 2  );
end




if plotTF == true
    
    set(0,'DefaultAxesFontName','arial');
    set(0,'DefaultAxesFontSize',14);

    impulse = impulse * 1e3;  % mV
    time = (t -phase) / p.sampleRate * 1000;   % ms
    plot( time', impulse', ':p' );
    grid ON;
    xlim( [ T/2 - p.spikePeriod*0.5, T/2 + p.spikePeriod*1]*1000  );
    ylim( [ -20 63] );
    xlabel('ms');
    ylabel('mV');
    
    if p.saveGraph == true
    
    chap = 'c6';
    sect = 's0';
    desc = 'impulsoRett';
    fileName = [chap sect desc];
    xts = 'epsc';
    path = 'graph/';
    
    % save and close figure
    saveas(gcf, [path fileName], xts);
    close;
    
end

end