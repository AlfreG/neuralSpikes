function tf = sfft(f)
% symmetric fast-fourier
% tf = sfft(f)
% % % % % acts columnwise unless f is a row vector
% modified: act rowwise always

[N,nc] = size(f);
isrow = 0;
% if N == 1
    isrow = 1;
    f = f.';
    N = nc;
    nc = 1 ;
% end

n = floor((N-1)/2);
tf = exp(1i*pi*(1-1/N)*[0:n,n+1-N:-1]')*ones(1,nc) .* fft(f);
tf = tf([n+2:N,1:n+1],:);

% if isrow
    tf = (tf.')/sqrt(2*pi);
% end