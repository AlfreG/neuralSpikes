function graphT0( p )
% Plot signal and filters in time domain.


% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, false);

% Sample's data
time       = (1:p.sampleSize) * 1000 / p.sampleRate;   % [ms]

% Add noise
signalN = signalR + thermalNoise(p, impulseParam);

    
% Spike times repositories and True spike indicator.
% spikesTime = spikesTime + round((p.spikePeriod * p.sampleRate)/2);
spikeTimes = round(impulseParam.start + impulseParam.midSize);
spikes             = NaN( 1, p.sampleSize );
spikes(spikeTimes) = signalN(spikeTimes);
spikes(spikeTimes) = 0;

    

close gcf;
hold on; 

plot( time, signalN(1,:)/3        , '--k', 'LineWidth', 0.1 );
plot( time, myFilter(signalN, p, 3), '-b' , 'LineWidth', 2);
plot( time, myFilter(signalN, p, 4), '-m' , 'LineWidth', 2);
plot( time, spikes, 'r^', 'MarkerFaceColor','r');

legend(  'Signal. ' + string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB.' +...
         ' SpikeRate ' + string(p.spikeRate) + 'Hz.', ...
         'Algor:LP.filt+arith.Mean', 'Algor:LP.filt+square.Mean','Spike', 'Location', 'NorthEast');
    grid ON;

%     title( string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB' );
    xlabel('ms');
    ylabel('mV');
%     set(gcf,'WindowStyle','docked');


saveGraph(p);

end




%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
%     % Global graphical settings
%     set(0,'DefaultAxesFontName','arial');
%     set(0,'DefaultAxesFontSize',11);
% 
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    chap = 'c1_';
    sect = ['I' num2str(p.impulseType) 'SNR' num2str(p.snrDb)];
    desc = 'time';
    fileName = [chap sect desc];
%     xts = 'epsc';
    path = 'results/';

    
    % save and close figure
    saveas(gcf, [path fileName], 'epsc');
    saveas(gcf, [path fileName], 'jpeg');
    saveas(gcf, [path fileName], 'fig');
    close;
    
end
end