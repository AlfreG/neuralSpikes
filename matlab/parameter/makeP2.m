% Spike train test

p2 = p;

p2.spikeRate      = 800;
p2.spikePeriod    = 1e-03;

%
p2.saveGraph     = false;

% Randomness
p2.noiseTF        = true;
p2.randomPhase    = false;
p2.snrDb          = 20;
p2.interSpikeType = 3;
p2.gammaStdErr    = 1;
p2.impulseType    = 2;
p2.smoothDFT      = true;
p2.smoothFIL      = false;

% Sampling 
p2.sampleRate    = 9000;
p2.sampleDuration= 0.01;

% Filtering
p2.highFreq      = 2500;
p2.lowFreq       = 10;
p2.filterOrder   = 2;
p2.filterType    = 'butter';

% Spikes
p2.amplitude     = 1;
p2.pixelNumber   = 1;
p2.waveVelocity  = 0;
p2.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p2.sampleSize  = round(p2.sampleRate*p2.sampleDuration);
p2.nyquist     = floor(p2.sampleSize/2);
p2.freq        = (-p2.nyquist:p1.nyquist-1)/p2.sampleSize * p2.sampleRate;
p2.spikeNumber = round( p2.spikeRate  * p2.sampleDuration );


%---------------
graphT0(p2)