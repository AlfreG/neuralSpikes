function timeErrorHisto( p )
%


% Set simulation range
p.saveGraph   = false;
p.impulseType = 1;
p.snrDb = 6;

% Set simulation parameters 
p.sampleRate      = 9*1e3;   % Hz
p.sampleDuration  = 1;      % s
p.spikeRate       = 150;      % Hz
p.spikeDuration   = 1e-3;    % s
p.lowFreq         = 0;      % Hz
p.highFreq        = 2500;    % Hz
p.pixelNumber     = 7;       %
p.noiseTF         = true;
p.waveVelocity    = 0;


% Make reference signal: a spike train with random sampling phase
[signalR, impulseParam] = spikeTrain(p, false);

% Add Noise
mP = impulseParam.mP;
noiseP = mP * 10^( -p.snrDb / 10 );
    sigma = sqrt( noiseP / p.spikePeriod );
    if p.noiseTF == true
        noise  = randn( [ p.pixelNumber, size(signalR, 2)] ) * sigma;
        signalN = signalR + noise; 
    end


% Filter noisy signal and get DFT
p.lowFreq  = 0;      % Hz
p.testType = 3;
[signalF3, ~, ~] = myFilter(signalN, p, false);
p.testType = 4;
[signalF4, ~, ~] = myFilter(signalN, p, false);
% Compute metrics
[~, distV4] = timeDist(signalF4, impulseParam, p);
[~, distV3] = timeDist(signalF3, impulseParam, p);



histogram( distV3, 'Normalization', 'pdf' ); hold on;
histogram( distV4, 'Normalization', 'pdf' );
legend('LPf+arith', 'LPf+square', 'Location', 'NorthEast');

stat( distV3, distV4 );

if p.saveGraph == true
    saveGraph(p);
end

end


%-------------------------------------------------------------------------
function saveGraph(p)

fileName = [ 'histo' num2str(p.impulseType) num2str(p.testType) num2str(p.snrDb)];
path = 'results/';

% save and close figure
saveas(gcf, [path fileName], 'jpg');
saveas(gcf, [path fileName], 'epsc');
close;

end


%-------------------------------------------------------------------------
function stat( x, y )

Label = {'LPf+arith';'LPf+square'};
Size  = [length(x);length(y)];
Mean  = [mean(x);mean(y)];
StdE   = [std(x)/sqrt(length(x));std(y)/sqrt(length(y))];
Kurtosis = [kurtosis(x);kurtosis(y)];
Skewness = [skewness(x);skewness(y)];

T = table(Label,Size,Mean,StdE,Kurtosis,Skewness)

end