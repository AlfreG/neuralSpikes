function graphSP( p )
%

p.saveGraph = true;

p.impulseType    = 2;
p.spikePeriod    = 1*1e-03;
p.snrDb          = 4;
p.highFreq       = 2500;
p.lowFreq        = 100;
p.spikeRate      = 70; %Hz
p.sampleDuration = 1;




% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, true, false);


% Sample data
sampleSize = size(signalR,2);                     % [SAMPLES]
% time       = (1:sampleSize) * 1000 / p.sampleRate;   % [ms]
cFreq      = p.sampleRate * (-sampleSize/2 : 1 : sampleSize/2-1) / sampleSize;  % [Hz]


% Reference signal. With no noise
q     = p;
q     = ID( signalR, q);
q     = SMOOTH(q);
psdR  = q.psd(1,:);


% Add noise
mP = impulseParam.mP;
noiseP = mP * 10^( -p.snrDb / 10 );
    sigma = sqrt( noiseP / p.spikePeriod );
    if p.noiseTF == true
        noise  = randn( [ p.pixelNumber, sampleSize ] ) * sigma;
        signalN = signalR + noise; 
    end

    

p1 = AV(BP(SMOOTH(ID(signalN, p))));
p1 = SMOOTH(p1);
psd1 = p1.psd( end, : );

p2 = MA(AV(SQ(BP(SMOOTH(ID(signalN, p))))));
p2 = SMOOTH(p2);
psd2 = p2.psd( end, : );

p3 = AV(LP(SMOOTH(ID(signalN, p))));
p3 = SMOOTH(p3);
psd3 = p3.psd( end, : );

p4 = MA(AV(SQ(LP(SMOOTH(ID(signalN, p))))));
p4 = SMOOTH(p4);
psd4 = p4.psd( end, : );





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
    
    % save caption
%     fileID = fopen([path fileName '.tex'],'w');
%     fprintf(fileID,caption);
%     fclose(fileID);
end
end