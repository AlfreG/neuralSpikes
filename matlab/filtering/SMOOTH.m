function p = SMOOTH(p)
% Normalized third order Moving Average filter


pixels = p.pixelNumber;
dft = p.dft( end-pixels +1 : end, : );
sampleSize = size( dft, 2 );

% Filter spectra
[B, A] = butter(2, 0.01,'low');
% B = [1 1 1]./3;
% A = [1 0 0];
dft    = filter( B, A, dft, [], 2 );

psd     = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);

% Update p
p.dft( end-pixels+1 : end, : )    = dft;
p.psd( end-pixels+1 : end, : )    = psd;

end

