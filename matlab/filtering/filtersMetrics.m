function [specD, timeD] = filtersMetrics( p )
%

% Get interspike times type
interTimes = p.interSpikeType;

% Make reference signal: a spike train with random sampling phase
[signalR, impulseParam] = spikeTrain(p, false);

% Spike train with constant inter spike times
p.interSpikeType = 3;
[signalC, ~] = spikeTrain(p, false);
p.interSpikeType = interTimes;
dftR  = myDft(signalC(1,:), p, " ");

% Add Noise
signalN = signalR + thermalNoise(p, impulseParam);
signalN = myFilter(signalN, p, p.testType);
dftN    = myDft(signalN, p, " ");

% Compute metrics
specD = dftNorm(dftR, dftN, p);
timeD = timeDist(signalN, impulseParam, p);