%
%

p4 = p;
p4.saveGraph     = true;
p4.simulationN    = 30;
p4.spikeRate      = 154;
p4.spikePeriod    = 1e-03;
p4.interSpikeType = 3;
    %case 1 %'exponential'  %exponentialy
    %case 2 %'uniform'  % uniformamly
    %case 3 %'constant' % constantly
    %case 4 %gamma
p4.gammaStdErr    = 0.01;
% Randomness
p4.noiseTF        = true;
p4.randomPhase    = true;
p4.snrDb          = -7;
p4.impulseType    = 5;
p4.smoothDFT      = false;
p4.smoothFIL      = false;

% Sampling 
p4.sampleRate    = 9500;
p4.sampleDuration= 0.7;

% Filtering
p4.highFreq      = 2500;
p4.lowFreq       = 20;
p4.filterOrder   = 2;
p4.filterType    = 'butter';

% Spikes
p4.amplitude     = 0.06;
p4.pixelNumber   = 7;
p4.waveVelocity  = 0;
p4.pixelDistance = 10;


% ----------------------------------------------------------------- Derived
p4.sampleSize  = round(p4.sampleRate*p4.sampleDuration);
p4.nyquist     = floor(p4.sampleSize/2);
p4.freq        = (-p4.nyquist:p4.nyquist-1)/p4.sampleSize * p4.sampleRate;
p4.spikeNumber = round( p4.spikeRate  * p4.sampleDuration );


%---------------
simula(p4)
graphS0(p4)
graphT0(p4)