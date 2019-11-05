function [metric, errors, timeDistance] = graphFT( p )
%



% Spike train with random sampling phase. Reference signal.
[signalR, impulseParam] = spikeTrain(p, true, false);


% Sample data
sampleSize = size(signalR,2);                     % [SAMPLES]
time       = (1:sampleSize) * 1000 / p.sampleRate;   % [ms]
cFreq      = p.sampleRate * (-sampleSize/2 : 1 : sampleSize/2-1) / sampleSize;  % [Hz]


% Reference signal. With no noise
q       = p;
q       = ID( signalR, q);
q       = SMOOTH(q);
psdRef  = q.psd(1,:);


% ------------------ check plot
% plot(mean( q.dft(:,:), 1));


% Add noise
mP = impulseParam.mP;
noiseP = mP * 10^( -p.snrDb / 10 );
    sigma = sqrt( noiseP / p.spikePeriod );
    if p.noiseTF == true
        noise  = randn( [ p.pixelNumber, sampleSize ] ) * sigma;
        signalN = signalR + noise; 
    end

    
% Spike times repositories and True spike indicator.
spikes     = NaN( 1, sampleSize );
filtSpikes = NaN( 1, sampleSize );
spikeTimes = impulseParam.start + impulseParam.max - 1;
spikes(spikeTimes) = p.amplitudeHighFreq;


% Choose sorting algorithm
switch p.algorType
    
    case 1 %    'simple'
        p = AV(BP(SMOOTH(ID(signalN, p))));
        p = SMOOTH(p);
        filterName = '1BP';
        filtSpikes = spikes * 0.5;
        
    case 2 %    'quadratic'
        p = MA(AV(SQ(BP(SMOOTH(ID(signalN, p))))));
        p = SMOOTH(p);
        filterName = '2BP';
        filtSpikes(spikesTime) = 3;

    case 3 %    'simpleLP'
        p = AV(LP(SMOOTH(ID(signalN, p))));
        p = SMOOTH(p);
        filterName = '1LP';
        filtSpikes = spikes * 0.5;
        
    case 4 %    'quadraticLP'
        p = MA(AV(SQ(LP(SMOOTH(ID(signalN, p))))));
        p = SMOOTH(p);
        filterName = '2LP';
        filtSpikes(spikesTime) = 3;
   
end



if p.saveGraph == true

    % Extract signal and filter data
    signal       = p.signal( 1, :)    ;
    psd          = p.psd( 1, :)       ;
    filtered     = p.signal( end, : ) ;    % pixel averaged and filtered signal
    psdFiltered  = p.psd( end, : )    ;


    subplot(2,2,1),     g1 = plot(time, signal, time, spikes);
        grid ON;
        title( [ 'Segnale. SNR= ', num2str(p.snrDb), ] );
        legend(  'Segnale', ...
             'Spike', ...
             'Location', 'SouthWest');
        xlabel('ms');
        ylabel('mV');

    subplot(2,2,3),     plot(cFreq, psd, cFreq, psdRef);
        grid ON;
        title('PSD');
        legend('filtSig', 'benchmark', 'Location', 'SouthWest');
        xlabel('Hz');
        ylabel('dB(V^2/Hz)');
        xlim([0, p.sampleRate/2]);
        ylim([-150, -40]);

    subplot(2,2,2),     g2 = plot(time, filtered, time, filtSpikes);
        grid ON;
        title( ['Segnale filtrato. Filt: ' filterName] );
        xlabel('ms');
        ylabel('mV');
    
    subplot(2,2,4),    plot(cFreq, psdFiltered, cFreq, psdRef );
        grid ON;
        title('PSD');
        legend('filtSig', 'benchmark', 'Location', 'SouthWest');
        xlabel('Hz');
        ylabel('dB(V^2/Hz)');
        xlim([0, p.sampleRate/2]);
        ylim([-150, -40]);


        g1(2).Marker = '*';
        g2(2).Marker = g1(2).Marker;
        % a3.XLim = [-50, maxFreq/2];
        % a3.YLim = [-100, -60];
        % a4.XLim = a3.XLim;
        % a4.YLim = a3.YLim;

    saveGraph(p);

    metric = zeros(4,1);

    else
        metric = dftNorm(q, p);
        errors = alfaBetaErrors(p, spikesTime);
        timeDistance   = timeDist(p, spikesTime);

end




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