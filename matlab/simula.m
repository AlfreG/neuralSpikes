function simula(p)


% Set simulation range
p.saveGraph   = true;
p.simulationN = 50;
p.impulseSpan = 1:5;
p.snrSpan     = 0:10;
p.testSpan    = 1:4;

% Set simulation parameters 
p.sampleRate      = 9*1e3;   % Hz
p.sampleDuration  = 50;       % s
p.spikeRate       = 30;      % Hz
p.spikeDuration   = 1e-3;    % s
p.lowFreq         = 100;     % Hz
p.highFreq        = 2500;    % Hz
p.pixelNumber     = 7;       %
p.noiseTF         = true;
p.waveVelocity    = 0;

% Repositories set up
snrSpanL     = length(p.snrSpan);
testSpanL    = length(p.testSpan);
impulseSpanL = length(p.impulseSpan);

%
N = p.simulationN;
for i = 1 : 1: impulseSpanL
    p.impulseType = p.impulseSpan(i);
    % reset repos at each impulse type
    specR = zeros( testSpanL, snrSpanL );
    timeR = zeros( testSpanL, snrSpanL );

    for r = 1: N

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
end


end