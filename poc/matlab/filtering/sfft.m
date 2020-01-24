function dft = sfft(signal)
% Symmetric fast-fourier along across

N    = size(signal,2);
n    = floor(N/2);     % nyquist's point

dft  = fft(signal,[],2)/sqrt(2*pi);
dft  = dft(:,[n+1:N,1:n]);
