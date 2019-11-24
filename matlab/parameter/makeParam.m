p = struct;

p.saveGraph = false;
p.simulationN = 50;

p.sampleRate= 9000;
p.sampleDuration = 1;

% Randomness
p.noiseTF = true;
p.randomPhase = true;

% Filtering
p.highFreq      = 2500;
p.lowFreq       = 100;
p.filterOrder   = 2;
p.filterType    = 'butter';
p.smoothDFT     = false;
p.smoothFIL     = false;

% Spikes
p.amplitude     = 0.06;
p.spikeRate     = 75;
p.spikePeriod   = 1e-03;
p.pixelNumber   = 7;
p.waveVelocity  = 0;
p.pixelDistance = 10;

% 
p.impulseType    = 1;
p.testType       = 1;
p.snrDb          = 5;
p.interSpikeType = 1;
p.gammaStdErr    = 1;

% Simulation ranges
p.interSpikeSpan    = [1 2 3];
p.snrSpan           = [2 3 5 6];
p.testSpan          = [1 2 3 4];
p.impulseSpan       = [1 2 3 4 5];
p.interSpikeTimes   = {'exponential'  'uniform'  'constant'};
p.impulseLabel      = {'rettangolare', 'gaussiano', 'gaussiano alternato', 'impulso neurale', 'sinusoidale','pointLike'};


% ----------------------------------------------------------------- Derived
p.sampleSize  = round(p.sampleRate*p.sampleDuration);
p.nyquist     = floor(p.sampleSize/2);
p.freq        = (-p.nyquist:p.nyquist-1)/p.sampleSize * p.sampleRate;
p.spikeNumber = round( p.spikeRate  * p.sampleDuration )