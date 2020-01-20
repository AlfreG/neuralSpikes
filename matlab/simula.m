function simula(p)

% Set simulation range
p.impulseSpan   = p.impulseType;
p.testSpan      = 1:4;
p.snrSpan       = -3:-1:-9;
p.spikeRateSpan = 54;

snrSpanL        = length(p.snrSpan);
testSpanL       = length(p.testSpan);
impulseSpanL    = length(p.impulseSpan);
spikeRateSpanL  = length(p.spikeRateSpan);

%
N = p.simulationN;
for i = 1 : 1: impulseSpanL
    p.impulseType = p.impulseSpan(i);
    % reset repos at each impulse type
    specR = zeros( testSpanL, snrSpanL );
    timeR = zeros( testSpanL, snrSpanL );

    for r = 1: N
        
        % show progress
        r

        for s = 1 : snrSpanL
            p.snrDb = p.snrSpan(s);
            
            for t = 1 : testSpanL
                p.testType   = p.testSpan(t);
    
                [specD, timeD]   = filtersMetrics( p );
                specR( t, s) = specR( t, s) + specD/N;
                timeR( t, s) = timeR( t, s) + timeD/N;
            end
        end
    end
    
    % Draw graph
    scatterPlot(specR, timeR, p);
    %scatterPlotRates(specR, timeR, p);
end


end