%% Spectral graph
% Low spike rate
% Highly variable intertimes
% High thermal noise

p4 = p;

p4.spikeRate      = 10;
p4.spikePeriod    = 1e-03;
p4.interSpikeType = 2;
p4.gammaStdErr    = 0.01;


%
p4.saveGraph     = false;

% Randomness
p4.noiseTF        = true;
p4.randomPhase    = true;
p4.snrDb          = 0;
p4.impulseType    = 5;
p4.smoothDFT      = true;
p4.smoothFIL      = true;

% Sampling 
p4.sampleRate    = 9000;
p4.sampleDuration= 1;

% Filtering
p4.highFreq      = 2500;
p4.lowFreq       = 20;
p4.filterOrder   = 2;
p4.filterType    = 'butter';

% Spikes
p4.amplitude     = 0.06;
p4.pixelNumber   = 1;
p4.waveVelocity  = 0;
p4.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p4.sampleSize  = round(p4.sampleRate*p4.sampleDuration);
p4.nyquist     = floor(p4.sampleSize/2);
p4.freq        = (-p4.nyquist:p4.nyquist-1)/p4.sampleSize * p4.sampleRate;
p4.spikeNumber = round( p4.spikeRate  * p4.sampleDuration );


%---------------
graphS0(p4)