function [metricStore, timesStore, p] = genGraph(p)
%--- Generate graph and save to path


% Set simulation parameters 
p.sampleRate      = 9*1e3;   % Hz
p.sampleDuration  = 1;       % s
p.spikeRate       = 10;      % Hz
p.spikeDuration   = 1e-3;    % s
p.lowFreq         = 100;     % Hz
p.highFreq        = 2500;    % Hz
p.pixelNumber     = 7;       %
p.noiseTF         = true;


snrSpanL     = length(p.snrSpan);
testSpanL    = length(p.testSpan);
impulseSpanL = length(p.impulseSpan);


% REsults' Repositories
metricStore  = zeros( 4, testSpanL, snrSpanL, impulseSpanL );
timesStore   = zeros( 1, testSpanL, snrSpanL, impulseSpanL );


    for j = 1 : 1: snrSpanL
        p.snrDb       = p.snrSpan(j);
        for k = 1 : 1: testSpanL
            p.algorType   = p.testSpan(k);
            for l = 1 : 1: impulseSpanL
                p.impulseType = p.impulseSpan(l);
                
                [metric, timeDistance]    = graphFT( p );
                metricStore( :, k, j, l)  = metric;
                 timesStore( :, k, j, l)  = timeDistance;
                  
            end
        end
    end
    
    
end