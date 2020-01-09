function    dist = dftNorm( dftR, dftN, p )
% dftR Reference DFT
% dftN Noisy DFT


checkPlot = false;

dft  = [dftR; dftN];


% Find the index of the stopband's frequencies
N            = size(dftR, 2);
k0           = ceil( N/2 );   %
%     kLow  = k0 + round( p.lowFreq  );
    kHigh = k0 + round( p.highFreq );


% Normalize spectrums
dft = dft - mean( dft, 2);
dft = dft ./ std( dft, [], 2);


% Find the index of the peak in Reference spectrum in band
[fMax, kMax] = max( dft(1, k0:end) );
    kMax = kMax + k0 - 1 ;
    delta = dft(2, kMax) - fMax;


% ------------------------------ Check plot
if checkPlot == true
    ind = k0:1:N;
    plot(  ind - k0, [ (dft(2,ind) - delta); dft(1,ind) ] );
        grid on;
        legend('filt', 'sig');
        xlabel('Hz');
        ylabel('V s^(1/2)');
    saveGraph(p);
end

% Equalize spectrum
dft = dft - [0; delta];
diff = dft(2,:) - dft(1,:) - delta;


dist = norm( diff( k0    : kHigh), 2 );

% Tab distance per frequency band
% dist = zeros(4,1);
%     dist(1) = norm( diff( k0    : kLow) , 2 );
%     dist(2) = norm( diff( k0    : kHigh), 2 );
%     dist(3) = norm( diff( k0     : end)  , 2 );
%     dist(4) = norm( diff( kHigh : end)  , 2 );
                    
end



%-------------------------------------------------------------------------
function saveGraph(p)

    
    % Global graphical settings
    set(0,'DefaultAxesFontName','arial');
    set(0,'DefaultAxesFontSize',11);

    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    chap = 'c7_';
    sect = ['I' num2str(p.impulseType) 'T' num2str(p.algorType) 'SNR' num2str(p.snrDb)];
    desc = 'Simulazione';
    fileName = [chap sect desc];
    xts = 'jpg';
    path = 'graph/';

    
    % save and close figure
    saveas(gcf, [path fileName], xts);
    close;
    
    % save caption
%     fileID = fopen([path fileName '.tex'],'w');
%     fprintf(fileID,caption);
%     fclose(fileID);
end

