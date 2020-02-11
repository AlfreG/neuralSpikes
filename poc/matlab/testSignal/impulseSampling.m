function impulse = impulseSampling( p )
% Impulse is a matrix whose number of rows = p.pixel
% and number of column = number of samples per spike

% Impulses' sampling parameters
V = p.amplitude;
T = p.spikePeriod;
N = round( T*p.sampleRate );
v = p.waveVelocity;
d = p.pixelDistance;
pixels = p.pixelNumber;


% Impulses' shape parameters
A  = N * sqrt(2/pi) / 2.5;
T1 = -2.5;
T2 = 0.3;


% Impulses' function cell array
rectangular = @(t) V * ( (t>0) .* (t<N) );
gaussian    = @(t) V * exp( -((t-N/2)/A).^2  );
sgaussian   = @(t) V * exp( -((t-N/2)/A).^2  ) .* (-1).^(1:N);
spikeShaped = @(t) gaussian( t - T1 ) - gaussian( t - T2 );
sinusoidal  = @(t) V * sin( 2*pi*t/N );
pointLike   = @(t) V * ( t==0 );
impulseFun  = {rectangular, gaussian, sgaussian, spikeShaped, sinusoidal, pointLike};


% Make impulse wave
if p.randomPhase == true
    phase = 2*(rand-0.5);
else
    phase = 0;
end
t     = ones(pixels, N) .* (0:1:N-1) - phase - v/d*(0:pixels-1)';
impulse = impulseFun{p.impulseType}(t);


end