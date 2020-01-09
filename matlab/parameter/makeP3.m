% fft test

p3 = p;

p3.spikePeriod    = 1e-03;
p3.spikeRate      = 1/p3.spikePeriod/900;
p3.spikeRate      = 50;
p3.interSpikeType = 3;
p3.gammaStdErr    = 0.01;


%
p3.saveGraph     = false;

% Randomness
p3.noiseTF        = false;
p3.randomPhase    = false;
p3.snrDb0         = 10*log10(p3.spikeRate*p3.sampleDuration*p3.mP/((p3.amplitude/5)^2)/p3.sampleDuration);
p3.snrDb          = p3.snrDb0;
p3.snrDb          = 15
p3.impulseType    = 2;
p3.smoothDFT      = false;
p3.smoothFIL      = false;

% Sampling 
p3.sampleRate    = 9000;
p3.sampleDuration= 1/1;

% Filtering
p3.highFreq      = 2500;
p3.lowFreq       = 10;
p3.filterOrder   = 2;
p3.filterType    = 'butter';

% Spikes
p3.amplitude     = 0.06;
p3.pixelNumber   = 7;
p3.waveVelocity  = 0;
p3.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p3.sampleSize  = round(p3.sampleRate*p3.sampleDuration);
p3.nyquist     = floor(p3.sampleSize/2);
p3.freq        = (-p3.nyquist:p3.nyquist-1)/p3.sampleSize * p3.sampleRate;
p3.spikeNumber = round( p3.spikeRate  * p3.sampleDuration );

%---------------
graphS0(p3)