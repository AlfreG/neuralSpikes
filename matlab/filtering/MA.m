function p = MA(p)
% Normalized third order Moving Average filter


pixels = p.pixelNumber;
signal = p.signal( end-pixels+1 : end, : );
sampleSize = size( signal, 2 );

B = [1 1 1]./3;
A = [1 0 0];

signal  = filter( B, A, signal, [], 2 );
dft     = abs(sfft( signal ) );
psd     = 2*dB( dft ) - dB(sampleSize) - dB(p.sampleRate);

% Update p
p.signal = [p.signal; signal ];
p.dft    = [p.dft   ; dft    ];
p.psd    = [p.psd   ; psd    ];
p.filter = [p.filter; '+MA'  ];

end

