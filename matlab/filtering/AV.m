function p = AV(p)
% Arithmetic mean of a cluster of pixels
%

pixels = p.pixelNumber;
signal = p.signal( end-pixels+1 : end, : );
signal = sum( signal, 1 )./pixels;
sampleSize = size( signal, 2 );


dft = abs(sfft( signal ) );
psd      = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);


p.signal = [p.signal; signal ];
p.dft    = [p.dft   ; dft    ];
p.psd    = [p.psd   ; psd    ];
p.filter = [p.filter; '+AV'  ];

p.pixelNumber = 1;      % update pixel number after averaging on the cluster

end

