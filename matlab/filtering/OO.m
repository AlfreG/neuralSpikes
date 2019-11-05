function p = OO(p)
% Do nothing filtering step
% just add the same previous lines to the archive

pixels = p.pixelNumber;
signal = p.signal( end-pixels+1:end, : );
dft    = p.dft( end-pixels+1:end, : );
psd    = p.psd( end-pixels+1:end, : );

p.signal = [p.signal;  signal ];
p.dft    = [p.dft;     dft ];
p.psd    = [p.psd;     psd    ];
p.filter = [p.filter; '+OO'   ];

end

