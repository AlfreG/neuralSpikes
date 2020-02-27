function spikeDistrib = spikeDistribution(signal, impulseParam, p)
% Prediction mean time error in [ms]
% Signal is the noisy filtered signal
% Trues spikes' time are stored in the struct impulseParam

% Sort true spike times
spikeMaxTimes = impulseParam.start + impulseParam.max;
spikeMaxTimes = sort(spikeMaxTimes, 'asc');

% Find signal's higher M spikes
M = size(spikeMaxTimes,2);
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(end-M+1:end);
maxInd      = sort(maxInd);

% Sum over signal time range
spikeD = zeros( p.sampleSize, 1 );
for x = maxInd
    spikeD(x,1) = 1 + spikeD(x,1) ;
end


% Count TP
spikeDistrib = zeros(2*M+1,1);
j=1;
for x = spikeMaxTimes
    count = 0;
    for y = x-4:1:x+4
        count = count + spikeD(y,1);
        spikeD(y,1) = 0;
    end
%     spikeD(x,1)=count;
    spikeDistrib(2*j,1) = count;
    j = j+1;
end


% Count FP
start = 1;
j=1;
for x = spikeMaxTimes
    count = 0;
    finish  = x-4;
    for y = start:1:finish-1
        count = count + spikeD(y,1);
        spikeD(y,1) = 0;
    end
    mid = round( start + (finish - start)/2 );
    spikeD(mid,1)= - count;
    start = finish+9;
    spikeDistrib(2*j-1,1) = -count;
    j = j+1;
end
