function [ signal, spikeTimes ] = sinusoidal(p)

w0  = 2*pi*(30)/p.sampleRate;
w1  = 2*pi*(35)/p.sampleRate;
w2  = 2*pi*(40)/p.sampleRate;

signal = sin( w0*(1 : 1 : p.sampleRate) );
signal = signal + sin( w1*(1 : 1 : p.sampleRate) );
signal = signal + sin( w2*(1 : 1 : p.sampleRate) );

spikeTimes = NaN('single');

end