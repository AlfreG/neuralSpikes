function metric = graphExplorePSD(signal, spikesTime, p, u, s, figureNum)


sampleSize = size(signal,2);                     % [SAMPLES]
time       = (1:sampleSize)*1000/p.sampleRate;   % [ms]
cFreq      = p.sampleRate*(-sampleSize/2:1:sampleSize/2-1)/sampleSize;  % [Hz]

p = BP(ID(signal, p));

signal     = p.signal(1,:);
psd        = p.psd(1,:);
filter     = p.signal( end, : );    % pixel averaged and filtered signal
psdFilter  = p.psd( end, : );

   
subplot(2,1,1),
    plot( time, filter );
        grid ON;
        title( [ 'Segnale. ' 'Lowf: ' num2str(p.lowfreq) ] );
%         xlim([10 time(round(sampleSize))]);
        xlim([time(round(sampleSize*3/5)) time(round(sampleSize*4/5))]);
        ylim([-50 50]);
        xlabel('ms');
        ylabel('mV');

subplot(2,1,2),
    semilogx(cFreq, psdFilter)
        grid ON;
        title('PSD');
        xlabel('Hz');
        ylabel('dB(V^2/Hz)');

% subplot(4,1,3),     g2 = plot(time, filter);
%     grid ON;
%     title('Segnale filtrato');
% %     xlabel('ms');
% %     ylabel('mV');
% 
% subplot(4,1,4),    
% semilogx(cFreq, psdFilter )
%     grid ON;
%     title('PSD');
% %     xlabel('Hz');
% %     ylabel('dB(V^2/Hz)');



if p.saveGraph == true
    
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    chap = 'c6_';
    sect = ['I' num2str(p.impulseType) 'T' num2str(p.algorType) 'SNR' num2str(p.snrDb)];
    desc = 'Simulazione';
    fileName = [chap sect desc];
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
