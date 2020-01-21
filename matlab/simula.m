function [cMatrixR, jaccardR, f1ScoreR] = simula(p)


% Set simulation range
snrSpanL        = length(p.snrSpan);
testSpanL       = length(p.testSpan);
impulseSpanL    = length(p.impulseSpan);

% Initialize accuracy metrics
cMatrixR = zeros(2,2, testSpanL);
jaccardR = zeros(1, testSpanL);
f1ScoreR = zeros(1, testSpanL);

N = p.simulationN;
L = N*impulseSpanL*snrSpanL;

for i = 1 : 1: impulseSpanL
    p.impulseType = p.impulseSpan(i);
    specR = zeros( testSpanL, snrSpanL );     % reset repos at each impulse type
    timeR = zeros( testSpanL, snrSpanL );

    for r = 1: N

        for s = 1 : snrSpanL
            p.snrDb = p.snrSpan(s);
            
            for t = 1 : testSpanL
                p.testType   = p.testSpan(t);
    
                [specD, timeD, cMatrix, jaccard, f1Score] = filtersMetrics( p );
                specR( t, s) = specR( t, s) + specD/N;
                timeR( t, s) = timeR( t, s) + timeD/N;
                
                % Record accuracy
                cMatrixR(:,:,t) = cMatrixR(:,:,t) + cMatrix/L;
                jaccardR(t) = jaccardR(t) + jaccard/L;
                f1ScoreR(t) = f1ScoreR(t) + f1Score/L;
            end
        end
    end
    
    % Draw scatter plot
    scatterPlot(specR, timeR, p);
end

% Round confusion matrix
cMatrixR=round(cMatrixR);

% Draw time and freq graphs
p.snrDb = -6;
graphSpectr(p)
graphTime(p)