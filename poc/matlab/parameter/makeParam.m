p = struct;


% -------------------------------------------------------------------------
% Simulation subset
% interSpikeType: 1, 2, 3=constant, 4=gamma
p.saveGraph      = false;
p.simulationN    = 30;
p.sampleRate     = 9000;
p.spikeRate      = 150;
p.sampleDuration = 1;
p.impulseType    = 2;
p.MA13_filter    = false;
p.MA24_filter    = true;
p.MA24_zerophase = true;
p.interSpikeType = 3;
p.tresholdNumber1 = 500;
p.tresholdNumber2 = 1000;
p.path           = 'results/';

% -------------------------------------------------------------------------
% Randomness
p.noiseTF = true;
p.randomPhase = false;

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
p.snrDb          = -10;
p.gammaStdErr    = 1;

% -------------------------------------------------------------------------
% Simulation ranges
p.interSpikeSpan    = 3;
p.snrSpan           = -20:1:-10;
p.testSpan          = [1 2];
p.impulseSpan       = 2; %[1 2 4 5];    % without impulse 3=gaus.alt
p.spikeRateSpan     = p.spikeRate;
p.interSpikeTimes   = {'exponential'  'uniform'  'constant'};
p.impulseLabel      = { 'Impulso rettangolare', 'Impulso gaussiano', 'Impulso gauss. alt.' ...
                      , 'Impulso neurale', 'Impulso sinusoidale','pointLike'};


% ------------------------------------------------------------------------- 
% Derived
p.sampleSize  = round(p.sampleRate*p.sampleDuration);
p.nyquist     = floor(p.sampleSize/2);
p.freq        = (-p.nyquist:p.nyquist-1)/p.sampleSize * p.sampleRate;
p.spikeNumber = round( p.spikeRate  * p.sampleDuration );
