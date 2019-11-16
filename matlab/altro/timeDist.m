function dist = timeDist(p, impulseParam)
% Spikes predicted time mean error
% On reference signal: spikes mid time

% Find signal's M-quantile
signal = p.signal( end, : );
M = impulseParam.length;
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(1,end-M : end);
maxInd      = sort(maxInd);

% Sort true spike times 
spikeMidTimes = impulseParam.start + round(M/2);
spikeMidTimes = sort(spikeMidTimes, 'asc');

% Distance in ms
disp = abs( maxInd - spikeMidTimes );
disp = disp(disp >= impulseParam.length);
dist = sum(disp) / M;
dist = dist / p.sampleRate * 1000;

end