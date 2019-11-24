function [dist, distV] = timeDist(signal, impulseParam, p)
% Prediction mean time error
% Signal is the noisy filtered signal
% Trues spikes' time are stored in the struct impulseParam


% Find signal's M-quantile
M = size(impulseParam.start,2);
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(end-M+1 : end);
maxInd      = sort(maxInd);

% Sort true spike times
spikeMidTimes = impulseParam.start + round(M/2);
spikeMidTimes = sort(spikeMidTimes, 'asc');

% Distance in ms
distV = abs( maxInd - spikeMidTimes );
distV = distV(distV >= impulseParam.size);

% 
dist = sum(distV) / M;
dist = dist / p.sampleRate * 1000;


% Log
% writeToLog( 'T' + string(p.testType) + 'I' + string(p.impulseType) + 'SNR' + string(p.snrDb) );
% writeToLog( mfilename );
% writeToLog( 'spikes number: ' + string(M) );
% writeToLog( 'max indeces length: '   + string(length(maxInd)) );
% writeToLog( 'impulse size: '   + string(impulseParam.size) );
% writeToLog( 'time dist: '      + string(dist) );
end


%-------------------------------------------------------------------------
% function histoGraph( distV, p)
% 
% histogram( dist, 'Normalization', 'pdf' );
% 
% fileName = [ 'histo' num2str(p.impulseType) num2str(p.testType) num2str(p.snrDb)];
% path = 'results/';
% 
% % save and close figure
% saveas(gcf, [path fileName], 'jpg');
% saveas(gcf, [path fileName], 'epsc');
% close;
% 
% end