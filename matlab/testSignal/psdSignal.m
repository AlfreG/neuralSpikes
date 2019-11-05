function psdSignal( p, plotTF )
% 

if nargin==0 % use to generate a single impulse signal
    
    p.saveGraph = false;
    plotTF = true;
    p.impulseType = 'gaussian';
    p.amplitudeHighFreq = 60*1e-3;      % V
    p.spikePeriod = 1e-3;               % s
    p.sampleRate  =  9*1e4;              % Hz
    rows = 1;                           % pixels
    p.sampleDuration = 1;               % s
    
end

p = ID( impulseSampling( p, rows, true), p);
psd = p.psd( 1 , : );
sampleSize = size( psd, 2 );
cFrequencies = p.sampleRate*( -sampleSize/2: 1 : sampleSize/2-1 ) / sampleSize;  % Hz


if plotTF == true
semilogx(cFrequencies, psd);
    grid ON;
    title('PSD');
%     xlim([-50 p.sampleRate/10]);
%     ylim([-400 -20]);
    xlabel('Hz');
    ylabel('dB(V^2/Hz)');
end

end
