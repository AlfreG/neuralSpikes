function enquiry( metricStore, timesStore, p, plotTF )
% dataStore  = zeros( 4, snrSpanL, testSpanL, impulseSpanL ); 

snrSpan     = p.snrSpan;
testSpan    = p.testSpan;
impulseSpan = p.impulseSpan;

snrSpanL     = length(snrSpan);
testSpanL    = length(testSpan);
impulseSpanL = length(impulseSpan);

% Metric
% @dB held fixed.
snr00   = min(2, snrSpanL );
band00  = 2;
metrics = reshape( metricStore( band00, :, snr00, : ), testSpanL , impulseSpanL );



if plotTF == true

   
plot(snrSpan',  m, '--*')
grid on;
%     title('Differenza distanze dallo spettro di riferimento: T2 - T1')
%     legend('recta','sinus','pgaus','gauss','spike','Location', 'North')
%     ylim([-20 20]);
    xlabel('dB');
    ylabel('V^2Hz');
end

end

    