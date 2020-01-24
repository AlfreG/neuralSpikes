function [ signal, spikeTimes] = gaussian(p)

V = p.amplitudeHighFreq;
A = ( p.spikePeriod * p.sampleRate ) * sqrt(2) / 3 / 2;
b = round( A * sqrt( pi / 2 ) );
T = p.sampleDuration;
halfN = ceil( T * p.sampleRate / 2 );
N = 2 * halfN;
t = linspace( 1, N, N);
sampleSize = N;

phase = 0;

signal = V * exp( -( ( t - halfN - phase )/A).^ 2  );

% sigma = p.amplitudeHighFreq * 10^(-p.snrDb/20);
areaV2 = 2127;  % (mV)^2 ms
sigma = 1e-3*sqrt(areaV2)*10.^( -p.snrDb / 20 );


if p.noiseTF == true
    noise  = randn( [ 1, sampleSize ] ) * sigma;
    signal = signal + noise; 
end

spikeTimes = NaN('single');

end