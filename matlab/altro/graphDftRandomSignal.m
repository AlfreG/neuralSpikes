function graphDftRandomSignal(p,u)

p.sampleNumber = 1024;
p.lowFreq     = 262;  %Hz DO4
p.highFreq    = 523;  %Hz D05
p.cutOffFreq  = 500;  %Hz
p.amplitudeLowFreq  = 1; %V
p.amplitudeHighFreq = 0.75; %V
p.phaseLowFreq  = 0;
p.phaseHighFreq = 0;
p.offset = 0.5;
p.snrDb = 2;
p.noiseTF = true;

p.filterOrder = 2;
p.filterType  = 'high';


size = p.samplesNumber;
time = (1:size)*1000/p.sampleRate;                      % ms
cFrequencies = p.sampleRate*(-size/2:1:size/2-1)/size;  % Hz

noiseMatrix = randn(size,1e4);
spectra = fft(noiseMatrix);
meanSpectra1 = abs(mean(spectra(:,1:1e1),2));
meanSpectra2 = abs(mean(spectra(:,1:1e2),2));
meanSpectra3 = abs(mean(spectra(:,1:1e3),2));
meanSpectra4 = abs(mean(spectra(:,1:1e4),2));


plot( cFrequencies, [meanSpectra1, meanSpectra2, meanSpectra3, meanSpectra4 ]);

    grid ON;
    legend('10','100', '1000', '10000');
    xlabel('Hz');
    ylabel('V');
    xlim( [0 p.sampleRate/2]);

end