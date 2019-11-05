function [Bx,Ax] = freqResp

N  =   1e3;                     % set points around the whole unit circle
sampleRate = 9*1e3;             % sampling frequency
freq = flip(sampleRate./(2:1:N));  % Evaluation frequencies

filterOrder  = 2;                       %
filterType   = 'high';                  %
highFreq = 500 ;                      % Hz
normFreq = 2*highFreq/sampleRate;     %

[Bx, Ax] = butter(filterOrder, normFreq, filterType);
h = freqz(Bx,Ax,freq,sampleRate);

%% 
chap = '5';
sect = '12';
desc = 'freqResp';
fileName = [chap sect desc];
xts = 'epsc';
path = 'graph/';

subplot(2,1,1), plot(freq,   20*log10(abs(h)) )
                grid on;
                line([highFreq highFreq],[-80 1]);
                xlabel('Hz');
                ylabel('dB');
                xlim([0 sampleRate*0.3]);
                ylim([-80 0]);
                
subplot(2,1,2), plot(freq, angle(h) )
                grid on;
                line([highFreq highFreq],[0 pi])
                xlabel('Hz');
                ylabel('rad');
                xlim([0 sampleRate*0.3]);


%% save and close figure
saveas(gcf, [path fileName], xts);
close;
                
end

