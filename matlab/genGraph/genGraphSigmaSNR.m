function genGraphSigmaSNR(p)
% Graph gaussian noise variance as a function of SNR
% given the impulse power of a sinusoidal period

p.saveGraph = true;

V0 = p.amplitudeLowFreq;
T  = p.spikePeriod;
sigma0 = V0/sqrt(2);

mP = V0*V0*T/2;     % signalpower
snrDb = -10:0.01:10;

noiseP = mP * 10.^( snrDb / 10 );
sigma = sqrt( noiseP / p.spikePeriod );

plot(snrDb, sigma * 1000);
    grid on;
    ylabel('\sigma [mV]');
    xlabel('SNR [dB]');
    line([0 0], [sigma0 sigma0], 'Color', 'k');

saveGraph(p);

end



%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
    % Global graphical settings
    set(0,'DefaultAxesFontName','arial');
    set(0,'DefaultAxesFontSize',11);

    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    chap = 'c6_';
    sect = 'graphSNR';
    %desc = 'Simulazione';
    fileName = [chap sect];
    xts = 'epsc';
    path = 'graph/';

    
    % save and close figure
    saveas(gcf, [path fileName], xts);
    close;
    
    % save caption
%     fileID = fopen([path fileName '.tex'],'w');
%     fprintf(fileID,caption);
%     fclose(fileID);
end
end