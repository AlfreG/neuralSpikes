function [ impulse, impulseParam ] = impulseSampling( p, rows, plotTF )
%
% mP = impulse's mean power
% label = 1; 'recta' 2; 'gauss' 3; 'pgaus' 4; 'spike' 5; 'sinus'


if nargin==0 % stab
    p.saveGraph         = false;
    plotTF              = true;
    p.impulseType       = 2;
    p.amplitudeHighFreq = 60*1e-3;      % V
    p.spikePeriod       = 1e-3;         % s
    p.sampleRate        = 9*1e3;        % Hz
    rows                = 7;            % pixels
end


V = p.amplitudeHighFreq;
T = p.spikePeriod;
N = round( T* p.sampleRate );
t = ones(rows, N) .* linspace( 1, N, N);

phase = (2*rand(rows,1)-1);

A = N * sqrt(2/pi) / 2;
B       = round(N/2);


switch p.impulseType
    
    case 1 % 'recta'
        impulse = zeros( rows, N );
        start   = round(phase);
        impulse( :, max(1,start): min(start + B,N) ) = V;
        
        
    case 2 % 'gauss'
        impulse = V * exp( -( ( t -round(N/2) - phase )/A).^ 2  );
    
   
    case 3 % 'pgaus'
        impulse = V * exp( -( ( t -round(N/2) - phase )/A).^ 2  );
        impulse = impulse .* (-1).^(1:1:N);

    
    case 4 % 'spike'
        A = A/2;
        V = V*1.3;
        impulse = V * exp( -( ( t -round(N/3.5) - phase )/A).^ 2  );
        impulse = impulse - 0.5 * V * exp( -( ( t -round(N/2) - phase )/A).^ 2  );
     
        
    case 5  % sinus
        impulse = V * sin( (2 * pi * (t - 1 + abs(phase)/2) / N) );

end



% Compute actual mean power
impulseParam.mP = impulsesMeanPower(impulse, p);


% Compute impulse time information
[~, maxTime] = max( abs(impulse),[], 2 );
impulseParam.max = round(mean(maxTime, 1));
impulseParam.length  = size(impulse, 2);




if plotTF == true
    
%     set(0,'DefaultAxesFontName','arial');
%     set(0,'DefaultAxesFontSize',14);

    impulse = impulse * 1e3;  % mV
    time = (t + 0) / p.sampleRate * 1000;   % ms
 
    plot( time', impulse', ':p' );
    title( ['Actual power =  ', num2str(impulseParam.mP*1e6) '  \mu V^2s.'] );
    grid ON;
    xlim( [ T/2 - p.spikePeriod*0.5, T/2 + p.spikePeriod*1]*1000  );
    ylim( [ -70 70] );
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

end


function meanPower = impulsesMeanPower(impulse, p)

    meanPower = mean( sum(impulse.^2, 2) ) / p.sampleRate; % V^2s

end