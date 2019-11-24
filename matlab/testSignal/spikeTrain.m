function [signal, impulseParam] = spikeTrain(p, plotTF )
%

sampleRate     = p.sampleRate;
sampleSize     = p.sampleSize;
spikeRate      = p.spikeRate;
spikeNumber    = p.spikeNumber;
pixels         = p.pixelNumber;

restPeriod  = round( sampleRate / spikeRate );
spikeSize   = round( p.spikePeriod * sampleRate );


% Sample spike times
switch p.interSpikeType
    case 1 %'exponential'  %exponentialy
    spikeTimes = expinv(rand([1,spikeNumber]), sampleRate/spikeRate);
    spikeTimes = cumsum(spikeTimes,2);
    spikeTimes = spikeTimes(spikeTimes< sampleSize - spikeSize);
    
    case 2 %'uniform'  % uniformamly
    spikeTimes =  sampleSize * rand( [1, spikeNumber] ) ;
    
    case 3 %'constant' % constantly
    spikeTimes = linspace(spikeSize + 1, sampleSize - spikeSize - 1, spikeNumber);

    case 4 %gamma
    spikeTimes = gamrnd(restPeriod/p.gammaStdErr, p.gammaStdErr, 1, spikeNumber);
    spikeTimes = cumsum(spikeTimes,2);
    spikeTimes = spikeTimes(spikeTimes< sampleSize - spikeSize);
    
    otherwise
    writeToLog('Unknown spike intertime sampling method. Using Default = exponential');
    spikeTimes = expinv(rand([1,spikeNumber]), sampleRate/spikeRate);
    spikeTimes = cumsum(spikeTimes,2);
    spikeTimes = spikeTimes(spikeTimes>= sampleSize - spikeSize);
end


% Log
% writeToLog( 'T' + string(p.testType) + 'I' + string(p.impulseType) + 'SNR' + string(p.snrDb) );
% writeToLog( mfilename );
% writeToLog( 'sample Size:   ' + string(sampleSize) );
% writeToLog( 'spikes number: ' + string(spikeNumber) );
% writeToLog( 'spikes gene.d: ' + string(length(spikeTimes)) );
% writeToLog( 'spike   times: ' + string(round(spikeTimes)) );


% Assemble signal
signal = zeros( pixels, sampleSize +  4 * restPeriod );
for j = ceil(spikeTimes)
    % Adiacent impulses might overlap
    impulse = impulseSampling( p );
    signal( :, j:j + spikeSize-1 ) = signal(:, j:j + spikeSize-1) + impulse;
end
% Compute actual power and max point in first pixel
testImpulse = impulseSampling( p );
impulseParam.mP        = impulsesMeanPower(testImpulse(1,:), p);
impulseParam.start     = spikeTimes;
impulseParam.midSize   = round(spikeSize/2);
impulseParam.size      = spikeSize;
[~, impulseParam.max]  = max(testImpulse(1,:)); 

% resize and demean signal
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