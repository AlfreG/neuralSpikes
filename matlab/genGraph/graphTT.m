function graphTT( p )
% Plot signal and filters in time domain.
%

p.saveGraph = false;

p.snrDb          = 0;
p.impulseType    = 5;
p.highFreq       = 2500;
p.lowFreq        = 100;
p.spikeRate      = 50; %Hz
p.sampleDuration = 0.08;
p.pixelNumber    = 10;
p.waveVelocity   = 10;
p.pixelDistance  = 5;



% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, false);


% Sample data
sampleSize = size(signalR,2);                     % [SAMPL
time       = (1:sampleSize) * 1000 / p.sampleRate;   % [ms]


% Add noise
mP = impulseParam.mP;   % mean impulse power
noiseP = mP * 10^( -p.snrDb / 10 );
    sigma = sqrt( noiseP / p.spikePeriod );
    if p.noiseTF == true
        noise  = randn( [ p.pixelNumber, sampleSize ] ) * sigma;
        signalN = signalR + noise; 
    end

    
% Spike times repositories and True spike indicator.
% spikesTime = spikesTime + round((p.spikePeriod * p.sampleRate)/2);
spikeTimes = round(impulseParam.start + impulseParam.size);
spikes             = NaN( 1, sampleSize );
spikes(spikeTimes) = signalN(spikeTimes);
spikes(spikeTimes) = 0.04;

    
% Unfiltered noisy signal
p0  = ID( signalN, p);
p0  = SMOOTH(p0);
f0  = p0.signal( end, : );

p3 = AV(LP(SMOOTH(ID(signalN, p))));
f3 = p3.signal( end, : );
        
p4 = MA(AV(SQ(LP(SMOOTH(ID(signalN, p))))));
f4 = p4.signal( end, : );
f4 = (f4 - mean(f4)) / std(f4) / 100;

close gcf;
hold on; 

plot( time, f0, '--k', 'LineWidth', 0.1 );
plot( time, f3, '-b', 'LineWidth', 2);
plot( time, f4, '-m', 'LineWidth', 2);
plot( time, spikes, 'r^', 'MarkerFaceColor','r');
    grid ON;
    legend(  'Signal. ' + string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB', ...
             'Algor:LP.filt+arith.Mean', ...
             'Algor:LP.filt+square.Mean', ...
             'Spike', ...
             'Location', 'NorthEast');
%     title( string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB' );
    xlabel('ms');
    ylabel('mV');
    set(gcf,'WindowStyle','docked');


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
    close;
    
end
end