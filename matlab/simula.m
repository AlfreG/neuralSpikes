function [metricStore, timesStore] = simula(p)



p.saveGraph   = false;    % if true save graph to path

p.impulseSpan = 2;
N = 50;

p.snrSpan     = 0:1:10;
p.testSpan    = 1:1:4;






snrSpanL     = length(p.snrSpan);
testSpanL    = length(p.testSpan);
impulseSpanL = length(p.impulseSpan);

bandSpan   = 4; % low band, in band, over band, all spectrum
timeSpan   = 1;

metricStore = zeros( bandSpan  , testSpanL, snrSpanL, impulseSpanL );
timesStore  = zeros( timeSpan  , testSpanL, snrSpanL, impulseSpanL );



for i = 1: 1: N
    
    [ metric, times, p ] = genGraph( p );
    
    metricStore = metricStore + metric;
    timesStore  = timesStore  + times;
    
end

metricStore = metricStore/N;
timesStore  = timesStore/N;

scatterPlot(metricStore, timesStore, p);
% enquiry(metricStore, timesStore, p, false);


end