function [cMatrix, jaccard, f1Score] = confusionMatrix(signal, impulseParam)
% Compute accuracy metrics.


% Initialize
cMatrix = zeros(2,2);

% Find signal's higher M pikes
M = size(impulseParam.start,2);
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(end-M+1:end);
maxInd      = sort(maxInd);

% Sort true spike times
spikeMidTimes = impulseParam.start;
spikeMidTimes = sort(spikeMidTimes, 'asc');

% Init for loop
target = spikeMidTimes;
guess  = maxInd;
found  = ones(size(target));

for x = guess
    [m, i] = min( abs(target - x) );
    
    if m <= impulseParam.size/2
        cMatrix(1,1) = cMatrix(1,1) + 1;     % got the spike!
        found(i) = 0;                        % set found
    else
        cMatrix(2,1) = cMatrix(1,1) + 1;     % sorry, try again.
    end
    
    rest = setdiff(1:length(guess), x);      % pop found guess
    guess = guess(rest);
end

cMatrix(1,2) = sum(found);          % missed spikes. True negative
cMatrix(2,2) = length(guess);      % missed spikes. False positive

jaccard = cMatrix(1,1) + cMatrix(2,2);
jaccard = jaccard / sum(cMatrix, [1 2]);

f1Score = 1/(cMatrix(1,1) / (cMatrix(1,1)+cMatrix(2,1))) + 1/(cMatrix(1,1) / (cMatrix(1,1)+cMatrix(1,2)));
f1Score = 1/f1Score;
