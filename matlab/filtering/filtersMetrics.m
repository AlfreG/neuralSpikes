function [specD, timeD] = filtersMetrics( p )
% A reference signal with deterministic spike rate and high SNR
% is compared to the filter of a noisy signal with random spike rate.
% Distance metrics in the domain of time and frequency are computed.


% Reference signal with constant spike rate
interTimes       = p.interSpikeType;    % Save this property for later use
p.interSpikeType = 3;
[signalR, ~]     = spikeTrain(p, false);
p.interSpikeType = interTimes;          % Reset the property
signalR = (signalR - mean( signalR, 2))./ std( signalR, [], 2);
dftR             = myDft(signalR(1,:), p, " ");

% Noisy signal with random spike rate
[signalN, impulseParam] = spikeTrain(p, false);
signalN = signalN + thermalNoise(p, impulseParam);
signalN = myFilter(signalN, p, p.testType);
signalN = (signalN - mean( signalN, 2))./ std( signalN, [], 2);
dftN    = myDft(signalN, p, " ");


% Compute metrics
specD = dftNorm(dftR, dftN, p);
timeD = timeDist(signalN, impulseParam, p);