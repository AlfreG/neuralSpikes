function graphSP( p )
%

p.saveGraph = false;

p.impulseType    = 2;
p.spikeRate      = 200; %Hz
p.sampleDuration = 30;
p.spikePeriod    = 1e-3;
p.snrDb          = 20;
p.highFreq       = 2500;
p.lowFreq        = 10;
p.waveVelocity   = 1;


% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, false);


% Sample data
sampleSize = size(signalR,2);                     % [SAMPLES]
cFreq      = p.sampleRate * (-sampleSize/2 : 1 : sampleSize/2-1) / sampleSize;  % [Hz]


% Add noise
mP = impulseParam.mP;
noiseP = mP * 10^( -p.snrDb / 10 );
    sigma = sqrt( noiseP / p.spikePeriod );
    if p.noiseTF == true
        noise  = randn( [ p.pixelNumber, sampleSize ] ) * sigma;
        signalN = signalR + noise; 
    end

    
% Reference psd: first pixel arithmetic mean of reference signal
p.testType = 1; [~, psdR] = myFilter(signalR(1,:), p,true);


p.testType = 1; [~, psd1] = myFilter(signalN, p, false);
p.testType = 2; [~, psd2] = myFilter(signalN, p, false);

p.lowFreq = 0; % only lowpass --> see myFilter.
p.testType = 3; [~, psd3] = myFilter(signalN, p, false);
p.testType = 4; [~, psd4] = myFilter(signalN, p, false);


%
plot( cFreq, psdR, 'k-' ); hold on;
plot( cFreq, psd1, 'b--' ); hold on;
plot( cFreq, psd3, 'c--' ); hold on;
plot( cFreq, psd2, 'r--' ); hold on;
plot( cFreq, psd4, 'm--' ); hold on;
        grid ON;
%         title( 'PSD. ' + string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB' );
        legend('Signal PSD. ' + string(p.impulseLabel(p.impulseType)), ...
            'BP.filt+arith.Mean', ...
            'LP.filt+arith.Mean', ...
            'BP.filt+square.Mean', ...
            'LP.filt+square.Mean');
        xlabel('Hz');
        ylabel('dB(V^2/Hz)');
        xlim([0, p.sampleRate/2]);
        text( 500, -120, 'spikeRate: '+ string(p.spikeRate) + 'Hz. ' + 'SNR: ' + string(p.snrDb)  );

        
saveGraph(p);

end


%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
    % Global graphical settings
%     set(0,'DefaultAxesFontName','arial');
%     set(0,'DefaultAxesFontSize',11);
% 
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    chap = 'c9_';
    sect = ['I' num2str(p.impulseType) 'SNR' num2str(p.snrDb)];
    desc = 'spec';
    fileName = [chap sect desc];
%     xts = 'jpg';
    path = 'results/';

    
    % save and close figure
    saveas(gcf, [path fileName], 'jpg');
    saveas(gcf, [path fileName], 'epsc');
    close;
    

end
end