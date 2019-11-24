% GraphS0 test

p3 = p;

p3.spikeRate      = 500;
p3.spikePeriod    = 1e-03;
% p3.spikeRate    = 1/p3.spikePeriod/100;
p3.interSpikeType = 4;
p3.gammaStdErr    = 0.01;


%
p3.saveGraph     = false;

% Randomness
p3.noiseTF        = true;
p3.randomPhase    = false;
p3.snrDb          = 6;
p3.impulseType    = 5;
p3.smoothDFT      = true;
p3.smoothFIL      = false;

% Sampling 
p3.sampleRate    = 9000;
p3.sampleDuration= 1;

% Filtering
p3.highFreq      = 2500;
p3.lowFreq       = 20;
p3.filterOrder   = 2;
p3.filterType    = 'butter';

% Spikes
p3.amplitude     = 0.06;
p3.pixelNumber   = 1;
p3.waveVelocity  = 0;
p3.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p3.sampleSize  = round(p3.sampleRate*p3.sampleDuration);
p3.nyquist     = floor(p3.sampleSize/2);
p3.freq        = (-p3.nyquist:p3.nyquist-1)/p3.sampleSize * p3.sampleRate;
p3.spikeNumber = round( p3.spikeRate  * p3.sampleDuration );


%---------------
graphS0(p3)