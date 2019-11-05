function enquiry( metricStore, errorsStore, timesStore, p, plotTF )
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
metrics = reshape( metricStore( band00, :, snr00, : ), testSpanL , impulseSpanL )


% Alfa Errors
% @dB held fixed.
% snr00   = min(2, snrSpanL );
% alfa00  = 1;
% errors = reshape( errorsStore( alfa00, :, snr00, : ), testSpanL , impulseSpanL )


% Beta Errors
% @dB held fixed.
% snr00   = min(2, snrSpanL );
% beta00  = 2;
% errors = reshape( errorsStore( beta00, :, snr00, : ), testSpanL , impulseSpanL )


if plotTF == true

% xx held fixed.
band00 = 4;
impulse00 = 2;
m = reshape( errorsStore( band00, :, :, impulse00 ), snrSpanL , testSpanL );
[snrSpan' m]
    
plot(snrSpan',  m, '--*')
grid on;
%     title('Differenza distanze dallo spettro di riferimento: T2 - T1')
%     legend('recta','sinus','pgaus','gauss','spike','Location', 'North')
%     ylim([-20 20]);
    xlabel('dB');
    ylabel('V^2Hz');
end

end

    