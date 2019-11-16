function [signal, impulseParam] = spikeTrain(p, plotTF )
%

% Stub parameters. [signal, impulseParam] = spikeTrain(param, true );
%     p.impulseType    = 2;
%     p.spikeRate      = 5;
%     p.sampleDuration = 0.1;
%     p.interSpikeType = 1;


    
sampleRate     = p.sampleRate;
spikeRate      = p.spikeRate;
sampleDuration = p.sampleDuration;
pixels         = p.pixelNumber;

sampleSize  = round( sampleRate * sampleDuration );
spikeNumber = round( spikeRate  * sampleDuration );
restPeriod  = round( sampleRate / spikeRate );
spikeSize   = round( p.spikePeriod * sampleRate );


% Sample spike times
switch p.interSpikeType
    case 1 %'exponential'  %exponentialy
    spikeTimes = -sampleRate * log( 1 - rand([1,spikeNumber]) ) / spikeRate;
    spikeTimes = cumsum(spikeTimes,2);
    spikeTimes = spikeTimes(spikeTimes< sampleSize - spikeSize);
    
    case 2 %'uniform'  % uniformamly
    spikeTimes =  sampleSize * rand( [1, spikeNumber] ) ;
    
    case 3 %'constant' % constantly
    spikeTimes = linspace(spikeSize + 1, sampleSize - spikeSize - 1, spikeNumber);
    
    otherwise
    disp('Unknown spike intertime ssampling method. Using Default = exponential');
    spikeTimes = -sampleRate * log( 1 - rand([1,spikeNumber]) ) / spikeRate;
    spikeTimes = cumsum(spikeTimes,2);
    spikeTimes = spikeTimes(spikeTimes>= sampleSize - spikeSize);
end



% Assemble signal
signal = zeros( pixels, sampleSize +  4 * restPeriod );
for j = round(spikeTimes)
    % Adiacent impulses might overlap
    impulse = impulseSampling( p );
    signal( :, j:j + spikeSize-1 ) = signal(:, j:j + spikeSize-1) + impulse;
end
% Compute actual power and max point in first pixel
testImpulse = impulseSampling( p );
impulseParam.mP        = impulsesMeanPower(testImpulse(1,:), p);
impulseParam.start     = spikeTimes;
impulseParam.size      = round(spikeSize/2);
[~, impulseParam.max]  = max(testImpulse(1,:)); 
% resize signal
signal = signal( :, 1:sampleSize ) ;


% Check plot
if plotTF == true
    figure;
    plot( signal(1,:) );
    xlabel('ms');
    ylabel('mv');
end

end


function meanPower = impulsesMeanPower(impulse, p)

    meanPower = mean( sum(impulse.^2, 2) ) / p.sampleRate; % V^2s

end