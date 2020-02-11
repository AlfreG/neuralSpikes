function [cMatrix, jaccard, f1Score] = confusionMatrix(signal, impulseParam)
% Compute accuracy metrics.


% Initialize
cMatrix = zeros(2,2);

% Sort true spike times
spikeMaxTimes = impulseParam.start + impulseParam.max;
spikeMaxTimes = sort(spikeMaxTimes, 'asc');

% Find signal's higher M pikes
M = size(impulseParam.start,2);
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(end-M+1:end);
maxInd      = sort(maxInd);

% Init for loop
target = spikeMaxTimes;
guess  = maxInd;
L = length(target);
spikeFound = zeros(1, L);
emptyFound = zeros(1, L);

for x = guess
    [m, i] = min( abs(target - x) );
    
    if m <= impulseParam.size/2
        spikeFound(i) = 1;
    else            
        if i==1 && x < target(i)
            emptyFound(L) = 1;
        elseif x > target(i)
            emptyFound(i) = 1;
        else
            emptyFound(i-1) = 1;
        end
    end
    
end

cMatrix(1,1) = sum(spikeFound, 2);
cMatrix(1,2) = L - cMatrix(1,1);
cMatrix(2,1) = sum(emptyFound, 2);
cMatrix(2,2) = L - cMatrix(2,1);

jaccard = cMatrix(1,1) + cMatrix(2,2);
jaccard = jaccard / sum(cMatrix, [1 2]);

f1Score = 1/(cMatrix(1,1) / (cMatrix(1,1)+cMatrix(2,1))) + 1/(cMatrix(1,1) / (cMatrix(1,1)+cMatrix(1,2)));
f1Score = 1/f1Score;
