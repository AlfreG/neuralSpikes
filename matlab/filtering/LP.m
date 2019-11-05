function p = BP(p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pixels = p.pixelNumber;
signal = p.signal( end-pixels+1:end, : );
sampleSize = size(signal,2);

% Low pass
[Bl, Al] = butter(p.filterOrder, 2*p.highFreq/p.sampleRate,'low');
signal = filter( Bl, Al, signal, [], 2 );

dft = abs( sfft( signal ) );

psd      = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);

% Update p
p.signal = [p.signal;  signal ];
p.dft    = [p.dft;     dft ];
p.psd    = [p.psd;     psd    ];
p.filter = [p.filter; '+LP'   ];

end

