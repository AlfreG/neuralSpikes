function    dist = dftNorm( dftR, dftN, p )
% Normalize DFTs and return their distance in the band
% dftR Reference DFT
% dftN Noisy DFT

dft  = [dftR; dftN];

% Find the index of the stopband's frequencies
N            = size(dftR, 2);
k0           = ceil( N/2 );   %
kLow  = k0 + round( p.lowFreq*N/p.sampleRate  );
kHigh = k0 + round( p.highFreq*N/p.sampleRate );

% Normalize spectrums
dft = (dft - mean( dft, 2) )./ std( dft, [], 2);

% Distance
diff = dft(1,:) - dft(2,:);
dist = norm( diff(k0:kHigh), 2 );