function table = genDbTable(p)

snrDb = -50:1:-30;
mP    = 1.8*1e-6;

noiseP = mP * 10.^( -snrDb / 10 );
sigma = sqrt( noiseP / p.sampleRate / p.spikePeriod );

table = [snrDb' sigma'];

% Global graphical settings
set(0,'DefaultAxesFontName','arial');
set(0,'DefaultAxesFontSize',12);

plot(table(:,1), table(:,2) ,'DisplayName','tableSNR')

% sigma = 0.06 mV line
m = min(snrDb);
M = max(snrDb);
noiseP = mP * 10.^( -[m M] / 10 );
sigma = sqrt( noiseP / p.sampleRate / p.spikePeriod );
x = -42.4;
y =   0.06;
line( [m x],   [0.06 0.06], 'Color', 'k', 'LineStyle', '--' );
line( [x x], [0 0.06], 'Color', 'k', 'LineStyle', '--'  );
xticks( [ m:2:floor(x-1) x ceil(x+1):2:M] );
yticks( [ 0:0.02:round(y-0.01,2) y round(y+0.01,2):0.02:0.15] );

grid on;
xlabel('SNR (dB)')
ylabel('Vs^{1/2}')

saveGraph(p);

end



%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [-7.5171; 6.145; 15; 15 ]);
        
    chap = 'c6_';
    sect = 'tabSNR';
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