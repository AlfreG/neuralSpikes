function area = bandArea(psd, lowFreq, highFreq, sampleSize, sampleRate)
% Power in a given frequency band.
% Compute area under power density

nyquist = floor( sampleSize / 2);
kLow  =   floor( sampleSize * lowFreq / sampleRate)  + nyquist;
kHigh =   floor( sampleSize * highFreq / sampleRate) + nyquist;

% area = sum(abs(real(spectra(kLow:kHigh))))*(sampleRate/size);
% area = sum(abs(imag(spectra(kLow:kHigh))))*(sampleRate/size) + area;
area = sum( psd( : , kLow:kHigh ), 2 ) / sampleRate;
area = area.*2;

end

