function [metricStore, errorsStore, timesStore] = genGraph(param, units, graphSorting)
%--- Generate graph and save to path


% Load parameters structures
p = param;
u = units;
s = graphSorting;


% Set simulation parameters 
p.sampleRate      = 9*1e3;   % Hz
p.sampleDuration  = 1;       % s
p.spikeRate       = 10;      % Hz
p.spikeDuration   = 1e-3;    % s
p.lowFreq         = 100;     % Hz
p.highFreq        = 2500;    % Hz
p.pixelNumber     = 7;       %
p.noiseTF         = true;


snrSpanL     = length(param.snrSpan);
testSpanL    = length(param.testSpan);
impulseSpanL = length(param.impulseSpan);


% REsults' Repositories
metricStore  = zeros( 4, testSpanL, snrSpanL, impulseSpanL );
errorsStore  = zeros( 2, testSpanL, snrSpanL, impulseSpanL );
timesStore   = zeros( 1, testSpanL, snrSpanL, impulseSpanL );


    for j = 1 : 1: snrSpanL
        p.snrDb       = p.snrSpan(j);
        for k = 1 : 1: testSpanL
            p.algorType   = p.testSpan(k);
            for l = 1 : 1: impulseSpanL
                p.impulseType = p.impulseSpan(l);
                
                [metric, errors, timeDistance]    = graphFT( p, u, s );
                metricStore( :, k, j, l) = metric;
                errorsStore( :, k, j, l) = errors;
                 timesStore( :, k, j, l) = timeDistance;
                  
            end
        end
    end
    
    
end