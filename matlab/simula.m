function [metricStore, errorsStore, timesStore, p] = simula(param, units, graphSorting)



param.saveGraph   = false;    % if true save graph to path
param.snrSpan     = [ 2 3 6 9];
param.impulseSpan = [ 5 4 2 1 3 ];
param.testSpan    = [ 1 2 3 4];

param.snrSpan     = 1:1:10;
param.impulseSpan = 1;
param.testSpan    = [ 1 2 3 4];



if param.saveGraph == true
    N = 1;
else
    N = param.repetitions;
    N = 50; %--------------------------------------------------------------
end


snrSpanL     = length(param.snrSpan);
testSpanL    = length(param.testSpan);
impulseSpanL = length(param.impulseSpan);

bandSpan   = 4; % low band, in band, over band, all spectrum 
errorsSpan = 2; % alfas, betas
timeSpan   = 1;

metricStore = zeros( bandSpan  , testSpanL, snrSpanL, impulseSpanL );
errorsStore = zeros( errorsSpan, testSpanL, snrSpanL, impulseSpanL );
timesStore  = zeros( timeSpan  , testSpanL, snrSpanL, impulseSpanL );



for i = 1: 1: N
    
    [ metric, errors, times ] = genGraph( param, units, graphSorting );
    
    metricStore = metricStore + metric;
    errorsStore = errorsStore + errors;
    timesStore  = timesStore  + times;
    
end

metricStore = metricStore/N;
errorsStore = errorsStore/N;
timesStore  = timesStore/N;

enquiry(metricStore, errorsStore, timesStore, param, false);

scatterPlot(metricStore, timesStore, param);

p = param;

end