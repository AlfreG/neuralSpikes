function p = SQ(p)
% Square signal and normalize
%

pixels = p.pixelNumber;
signal = p.signal( end-pixels+1 : end, : );
sampleSize = size( signal, 2 );

signal = signal ./ std(signal, [], 2);
signal = signal.^2;
dft = abs( sfft( signal ) );

psd      = 2*dB( abs(sfft( dft ) ) ) - dB(sampleSize) - dB(p.sampleRate);

p.signal = [p.signal; signal];
p.dft    = [p.dft   ; dft];
p.psd    = [p.psd   ; psd];
p.filter = [p.filter; '+SQ'];

% [power, powerTot] = powerBand( y, p.lowFreq, p.highFreq, size, p.sampleRate);
% p.power  = [ p.power ; power ];
% p.powerTot  = [ p.powerTot ; powerTot ];

end

