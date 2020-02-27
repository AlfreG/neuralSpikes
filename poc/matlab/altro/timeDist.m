function delay = timeDist(signal, impulseParam, p)
% Prediction mean time error in [ms]
% Signal is the noisy filtered signal
% Trues spikes' time are stored in the struct impulseParam


% Sort true spike times
spikeMaxTimes = impulseParam.start + impulseParam.max;
spikeMaxTimes = sort(spikeMaxTimes, 'asc');

% Find signal's higher M spikes
% M = size(spikeMaxTimes,2);
M = 500;
[~, maxInd] = sort(signal, 'asc');
maxInd      = maxInd(end-M+1:end);
maxInd      = sort(maxInd);

delay = 0;

% distribution = -9*zeros(M,1);
% j=1;

for x = maxInd
    
    m = min( abs(spikeMaxTimes - x) );
%     distribution(j) = m;
%     j= j+1;
    
    delay = delay + m;

%     if m > delay
%         delay = m;
%     end

 end

delay = delay / M / p.sampleRate * 1000;
% delay = delay / p.sampleRate * 1000;

% histogram( distribution, 'Normalization', 'pdf' );

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