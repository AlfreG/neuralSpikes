% Test parametrization
% No randomness

p1 = p;

%
p1.saveGraph     = false;

% Randomness
p1.noiseTF        = true;
p1.randomPhase    = false;
p1.snrDb          = 20;
p1.interSpikeType = 1;
p1.gammaStdErr    = 1;
p1.impulseType    = 2;
p1.spikeRate      = 500;
p1.spikePeriod    = 2*1e-03;
p1.smoothDFT      = true;
p1.smoothFIL      = false;

% Sampling 
p1.sampleRate    = 9000;
p1.sampleDuration= 1;

% Filtering
p1.highFreq      = 2500;
p1.lowFreq       = 10;
p1.filterOrder   = 2;
p1.filterType    = 'butter';

% Spikes
p1.amplitude     = 0.06;
p1.pixelNumber   = 7;
p1.waveVelocity  = 0;
p1.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p1.sampleSize  = round(p1.sampleRate*p1.sampleDuration);
p1.nyquist     = floor(p1.sampleSize/2);
p1.freq        = (-p1.nyquist:p1.nyquist-1)/p1.sampleSize * p1.sampleRate;
p1.spikeNumber = round( p1.spikeRate  * p1.sampleDuration );


%---------------
% graphS0(p1)