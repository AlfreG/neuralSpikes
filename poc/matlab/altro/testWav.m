function testWav(p, data, fs, plotYN)


%% import signal

% newData1 = importdata('data/diapason.wav');
% 
% % Create new variables in the base workspace from those fields.
% vars = fieldnames(newData1);
% for i = 1:length(vars)
%     assignin('base', vars{i}, newData1.(vars{i}));
% end

% load('data/data.mat');
% load('data/fs.mat');


%%
T = switchType(p.precision); % 'double', 'fixed16'


%% Fourier transform

signal = data(:,1);
    N = size(signal,1);
    M = round(N/2);
    p.sampleRate = fs;
    p.duration = N/fs;

spectra = 20*log10(abs(fft(signal))); 
    [y,n] = max(spectra);

time = (0:N-1)/p.sampleRate;

%% Graphs

if plotYN == 'plotY'

subplot(2,1,1), % frequences domain

    plot(time, signal);
    grid ON;
    xlabel('s');
    ylabel('dB');


subplot(2,1,2), % frequences domain
    
    plot( spectra);
    text(n, y, ['v=' num2str(n) ' Hz'] );
    grid ON;
    xlabel('Hz');
    ylabel('dB');
end

end
