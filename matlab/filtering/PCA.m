function p = AV(p)
% Arithmetic mean of the pixels in cluster
%   Detailed explanation goes here

pixels = p.pixelNumber;
signal = p.signal( end-pixels+1 : end, : );
[ U, S, V ] = svd(signal');
signal = S(1,1)*U(:,1)';
sampleSize = size( signal, 2 );
S(1,1)
S(2,2)

dft = abs(sfft( signal ) );

psd      = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);

p.signal = [p.signal; signal ];
p.dft    = [p.dft   ; dft    ];
p.psd    = [p.psd   ; psd    ];
p.filter = [p.filter; '+PC'  ];


end

