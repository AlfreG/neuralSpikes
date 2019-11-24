function testSfft

% sampling params
sampleRate  = 9000;             % Hz
elapse      = 2;                % s
v           = [ 100 ]';         % Hz

%
sampleSize  = round(sampleRate*elapse);
n           = floor(sampleSize/2);
ind         = [n+1:sampleSize,1:n];
maxFreq     = floor(sampleRate/2);
freq        = (-n:n-1) * maxFreq/n;

%
signal = sin( 2*pi*(1:sampleSize) .* v / sampleRate );
signal( signal < 0.8 ) = 0;
signal = abs(signal.^2);
signal = signal - mean(signal,2);
dft    = abs( fft(signal,[],2) ) / sqrt(2*pi) / sqrt(sampleSize);
dft    = dft(:,ind);


plot( freq, dft);
%     xlim ( [-10 50] );
    
% plot( freq, signal, '.');
% [~,I]= max(dft);
% n-I+2