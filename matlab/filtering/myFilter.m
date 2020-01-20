function signal = myFilter(signal, p, testType)
% Signal filtering and averaging along pixels


% Low pass
[B, A] = butter(p.filterOrder, 2*p.highFreq/p.sampleRate,'low');
signal = filter( B, A, signal, [], 2 );


% High pass
if (testType == 1) || (testType == 2)
    [B, A] = butter(p.filterOrder, 2*p.lowFreq/p.sampleRate,'high');
    signal = filter( B, A, signal, [], 2 );
end


% Pixels aggregation
switch testType
    case {1,3}
        signal = mean(signal,1);
    otherwise
        signal = mean(signal.^2,1);
%         B = [1 1 1];
%         A = [1 0 0]
%         signal = filter( B, A, signal, [], 2 );
end


% Normalize signal
signal = signal - mean(signal,2);
signal = signal ./ std(signal, [], 2) / 500;
