function out = myDft(signal, p, psdString)
% Compute DFT, PSD. 


dft = abs( sfft( signal ) )/sqrt(p.sampleSize);


if p.smoothDFT == true
    [B, A] = butter(2, 0.5,'low');
    dft    = filter( B, A, dft, [], 2 );
end


if psdString == "psd"
    out = 2*dB( dft ) - dB(p.sampleSize) - dB(p.sampleRate);
else
    out = dft;
end