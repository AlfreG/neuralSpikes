function scatterPlot( metricStore, timesStore, p )
% 


snrSpan     = p.snrSpan;
testSpan    = p.testSpan;
impulseSpan = p.impulseSpan;

snrSpanL     = length(snrSpan);
testSpanL    = length(testSpan);
impulseSpanL = length(impulseSpan);

band00  = 2;
metrics = reshape( metricStore( band00, :, :, : ), testSpanL , impulseSpanL*snrSpanL );
times   = reshape(  timesStore( 1     , :, :, : ), testSpanL , impulseSpanL*snrSpanL );


% Scatter plot
times   = reshape( times  , testSpanL*impulseSpanL*snrSpanL, 1);
metrics = reshape( metrics, testSpanL*impulseSpanL*snrSpanL, 1);
snrs = reshape( repmat( snrSpan',1,testSpanL*impulseSpanL)', 1,snrSpanL*testSpanL*impulseSpanL);


% Test 1 - 
hold on;
ind = 1:4:size(times,1);
plot(times(ind), metrics(ind), 'b.-', 'MarkerSize', 12);
text(times(ind)+3, metrics(ind), string(snrs(ind)), 'FontSize', 12);

ind = 3:4:size(times,1);
plot(times(ind), metrics(ind), 'c.-', 'MarkerSize', 12);
text(times(ind)+3, metrics(ind), string(snrs(ind)), 'FontSize', 12);

ind = 2:4:size(times,1);
plot(times(ind), metrics(ind), 'r.-', 'MarkerSize', 12);
text(times(ind)+3, metrics(ind), string(snrs(ind)), 'FontSize', 12);

ind = 4:4:size(times,1);
plot(times(ind), metrics(ind), 'm.-', 'MarkerSize', 12);
text(times(ind)+3, metrics(ind), string(snrs(ind)), 'FontSize', 12);


grid on;
legend('BPf+arith', 'LPf+arith', 'BPf+square', 'LPf+square', 'Location', 'SouthEast');
title( string(p.impulseLabel(p.impulseType)) );
xlabel('Mean time displacement [ms]');
ylabel('Spectral distance [Vs^{0.5}]');

p.saveGraph = true;
saveGraph(p);

end





%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
    % Global graphical settings
%     set(gcf,'DefaultAxesFontName','arial');
%     set(gcf,'DefaultAxesFontSize',12);
% 
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    sect = [ 'scatter' num2str(p.impulseSpan) ];
    fileName = sect;
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

    