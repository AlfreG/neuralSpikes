function [specD, timeD] = filtersMetrics( p )
%


% Make reference signal: a spike train with random sampling phase
[signalR, impulseParam] = spikeTrain(p, false);
% Compute reference signal DFT
[~, dftR, ~] = myFilter(signalR, p, true);

% Add Noise
signalN = signalR + thermalNoise(p, impulseParam); 


% Filter noisy signal and get DFT
[signalF, dftF, ~] = myFilter(signalN, p, false)    ;
% Compute metrics
specD = dftNorm(dftR, dftF, p);
timeD = timeDist(signalF, impulseParam, p);