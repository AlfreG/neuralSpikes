function corr = correlogram(signal, plotTF)
% correlogram of demeaned signal
% signal must be columnwise


signal = signal
size = length(signal)
corr = triu(ones(size,size)).*signal
corr = tril(ones(size,size)).*signal


end