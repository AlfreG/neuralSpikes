function firTF(p)
% Unnormalized FIR impulse response functions of n orders
% for SIGNAL and SQUARED SIGNAL
% -- with no inputs defaults values are used


w = 0 : 1e-3 : pi;
H = freqz( [1 0 0], [1 1 1], w );

plot( w*p.sampleRate/2/pi, 2*pi./angle(H) );
    xlim([0 1000]);



end
