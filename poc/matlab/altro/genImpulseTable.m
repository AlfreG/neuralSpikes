function genImpulseTable(p)

p.saveGraph         = true;
plotTF              = true;
p.amplitudeHighFreq = 60*1e-3;      % V
p.spikePeriod       = 1e-3;         % s
p.sampleRate        = 9*1e3;        % Hz
rows                = 7;            % pixels

T = p.spikePeriod;
N = round( T* p.sampleRate );


t = ones(rows, N) .* linspace( 1, N, N);
time = t / p.sampleRate * 1000;   % ms

for i = [2 3 4 5]
    
    p.impulseType = i;
    [impulse, mP, label] = impulseSampling( p, rows, false );
    impulse = impulse * 1e3;  % mV
    
    subplot(2,2,i-1),    plot( time', impulse', ':p' );
    title( [ 'Impulso ' '"' label '"' ' id: ' num2str(i) ]  );
    legend(  [ 'Impulse power =  ', num2str(round(mP*1e6,2)) '  \mu V^2s.'], 'Location', 'South' );
    grid ON;
    xlim( [ T/2 - p.spikePeriod*0.5, T/2 + p.spikePeriod*1]*1000  );
    ylim( [ -70 70] );
    xlabel('ms');
    ylabel('mV');


end




saveGraph(p);

end



%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true

    set(0,'DefaultAxesFontName','arial');
    set(0,'DefaultAxesFontSize',10);

    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [-7.5171; 6.145; 20; 20 ]);
        
    chap = 'c6_';
    sect = 'impulseTable';
    desc = '';
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

