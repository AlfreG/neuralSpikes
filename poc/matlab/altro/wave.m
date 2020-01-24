% Impulse
sigma  = 1;
points = 1e3; 
spanFactor   = 8;

x = linspace(-spanFactor*sigma, spanFactor*sigma, points);

y = normpdf(x, 0, sigma) - normpdf(x, sigma*sqrt(2), sigma*sqrt(7) );
y = y./max(abs(y));



% Impulse sampling
sampleRate    = 9000;      % Hz
impulsePeriod = 1e-3;      % s
samples = round( sampleRate * impulsePeriod );
step    = round( points / samples);

s = NaN(1, length(y));
s(round(step/2):step:end) = 1;

time = (0:points-1) * impulsePeriod/points * 1000 ;   % ms
z = y.*s;

signal = 
plot( time,  y ); hold on
plot( time,  z, '.', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'MarkerSize', 12);
    xlabel('time [ms]');
    ylabel('V');

z = z ( ~isnan(z) )