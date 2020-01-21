p = struct;


% -------------------------------------------------------------------------
% Simulation subset
% interSpikeType: 1, 2, 3, 4
p.saveGraph      = true;
p.simulationN    = 10;
p.sampleRate     = 9000;
p.spikeRate      = 150;
p.sampleDuration = 1;
p.impulseType    = 1;
p.MA_filter      = false;
p.interSpikeType = 3;

% -------------------------------------------------------------------------
% Randomness
p.noiseTF = true;
p.randomPhase = true;

% -------------------------------------------------------------------------
% Filtering
p.highFreq      = 2500;
p.lowFreq       = 20;
p.filterOrder   = 2;
p.filterType    = 'butter';
p.smoothDFT     = false;
p.smoothFIL     = false;

% -------------------------------------------------------------------------
% Spikes shape
p.amplitude     = 0.06;
p.mP            = 1.8*1e-6; % V^2s
p.spikePeriod   = 1e-03;
p.pixelNumber   = 7;
p.waveVelocity  = 0;
p.pixelDistance = 10;

% -------------------------------------------------------------------------
% Signal and spikes train
p.testType       = 1;
p.snrDb          = 6;
p.gammaStdErr    = 0.1;

% -------------------------------------------------------------------------
% Simulation ranges
p.interSpikeSpan    = [1 2 3];
p.snrSpan           = -3:-1:-9;
p.testSpan          = [1 2 3 4];
p.impulseSpan       = [1 2 3 4 5];
p.spikeRateSpan     = p.spikeRate
p.interSpikeTimes   = {'exponential'  'uniform'  'constant'};
p.impulseLabel      = { 'rettangolare', 'gaussiano', 'gaussiano alternato' ...
                      , 'impulso neurale', 'sinusoidale','pointLike'};


% ------------------------------------------------------------------------- 
% Derived
p.sampleSize  = round(p.sampleRate*p.sampleDuration);
p.nyquist     = floor(p.sampleSize/2);
p.freq        = (-p.nyquist:p.nyquist-1)/p.sampleSize * p.sampleRate;
p.spikeNumber = round( p.spikeRate  * p.sampleDuration );
