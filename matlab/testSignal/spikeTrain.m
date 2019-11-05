function [signal, impulseParam] = spikeTrain(p, randomSpikeTF, plotTF )
% Each pixel senses the same spike at the same spike time


sampleSize  = round( p.sampleRate * p.sampleDuration );
spikeNumber = round(  p.spikeRate * p.sampleDuration );
restPeriod  = round( p.sampleRate / p.spikeRate );
pixels      = p.pixelNumber;
time        = (1:sampleSize)*1000/p.sampleRate; % ms
signal      = zeros( pixels, sampleSize +  4 * restPeriod );


if randomSpikeTF == true
    spikeTimes =  ceil( sampleSize * rand( [1, spikeNumber] ) );
else
    T = p.spikePeriod;
    N = round( T* p.sampleRate );
    spikeTimes =  N : restPeriod : sampleSize;
end
    
    
[impulse, impulseParam] = impulseSampling( p, spikeNumber * pixels, false );
impulseParam.start = spikeTimes;
waveSamples = size( impulse,2 );
    
i = 1;
for j = spikeTimes
    signal( :, j:j + waveSamples-1 ) = signal(:, j:j + waveSamples-1) + impulse(i:i+pixels-1,:);
    i = i+pixels;
end
    
signal = signal( :, 1:sampleSize ) ;



if plotTF == true
    figure;
    plot( time, signal(1,:) );
    xlabel('ms');
    ylabel('mv');
end

end