function p = ID(signal, p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sampleSize = size(signal,2);

dft  = abs( sfft( signal ) );
psd      = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);

p.signal = [ ];
p.dft = [ ];
p.psd = [ ];
p.filter = [ ];
p.power  = [ ];
p.powerTot  = [ ];

p.signal = [ p.signal; signal ];
p.dft    = [ p.dft;    dft ];
p.psd    = [ p.psd;    psd   ];
p.filter = [ p.filter; ' SG' ];

% [power, powerTot] = powerBand( y, p.lowFreq, p.highFreq, size, p.sampleRate);
% p.power  = [ p.power ; power ];
% p.powerTot  = [ p.powerTot ; powerTot ];


end

