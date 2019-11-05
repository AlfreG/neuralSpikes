function signal = mySignal(p, plotTF)
% Generate a sinusoidal sampled signal given the signal frequencies
% and amplitudes. Optional noise and offset.
%
% sampleRate  = p.sampleRate;         % Hz
% highFreq    = p.highFreq;           % Hz
% lowFreq     = p.lowFreq;            % Hz
% cutOffFreq  = p.cutOffFreq;         % Hz
% offset      = p.offset;
% snr_db      = p.snr_db;             % dB
% filterOrder = p.filterOrder;
% filterType  = p.filterType;         % high, pass, filter

N   = p.samplesNumber;
w0  = 2*pi*p.lowFreq/p.sampleRate;
w1  = 2*pi*p.highFreq/p.sampleRate;
A0  = p.amplitudeLowFreq;
A1  = p.amplitudeHighFreq;
f0  = p.phaseLowFreq;
f1  = p.phaseHighFreq;
snr = 10^(p.snrDb/20);

signal = zeros(N,1);

for n = 1:1:N
    signal(n) = signal(n) +  A0*cos(n*w0 + f0);
    signal(n) = signal(n) +  A1*cos(n*w1 + f1);
    signal(n) = signal(n) +  p.offset;
end

if p.noiseTF == true
    noise  = randn( [N, 1] )/snr;
    signal = signal+noise; 
end

if plotTF == true
    plot(1:N, signal(:));
end

end
