function graphHist( p )
% Plot signal and filters in time domain.


% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, false);

% Add noise
signalN = signalR + thermalNoise(p, impulseParam);


% graph
hold on; 
subplot(2,1,1), histogram( myFilter(signalN, p, 1), 'Normalization', 'cdf' );
                grid on;
                ylim([0.8 1]);
                xlim([0 10*1e-3]);
subplot(2,1,2), histogram( myFilter(signalN, p, 2), 'Normalization', 'cdf' );
                ylim([0.8 1]);
                xlim([0 14*1e-3]);
                grid on;