function graphFilteringNoNoise(p, plotTF)

p.lowFreq     = 262;  %Hz DO4
p.highFreq    = 523;  %Hz D05
p.cutOffFreq  = 500;  %Hz

signal = mySignal(p,0);

[B, A] = butter(p.filterOrder, 2*p.cutOffFreq/p.sampleRate,p.filterType);

filteredSig = filter( B, A, signal );


%% 
chap = '5';
sect = '13';
desc = 'filtering1';
fileName = [chap sect desc];
xts = 'epsc';
path = 'graph/';


if plotTF == 1
size = p.samplesNumber;
timeScaling = 1000/p.sampleRate; % ms

subplot(2,1,1), % time domain 
    plot( (1:size)*timeScaling, [ signal filteredSig ]); 
    grid ON;
    legend('signal','filtered sig');
    title( [ 'sampleRate = '    num2str(p.sampleRate) ...
             ' lowFreq = '       num2str(p.lowFreq) ...
             ' HighFreq = '      num2str(p.highFreq) ...
             ] );
    xlim([ 0 p.sampleRate/(p.highFreq-p.lowFreq) ]);
    xlabel('ms');
    ylabel('V');

    
subplot(2,1,2), % frequences domain
  
    frequencies = p.sampleRate*(-size/2:1:size/2-1)'/size;
 
    signalDb      = 20*log10(abs(sfft( signal ))); 
    filteredSigDb = 20*log10(abs(sfft( filteredSig )));
    trasferFunc   = 20*log10(abs(freqz(B, A, frequencies, p.sampleRate)));
    
    plot( frequencies, [signalDb filteredSigDb trasferFunc] );

    grid ON;
    title([  'DFT'  ...
             ' fOrder = '        num2str(p.sampleRate) ...
             ' cutoffFreq = '    num2str(p.cutOffFreq) ...
             ]);
    legend(  'signal' ...
            ,'filteredSig' ...
            ,'Trasfer function' ...
             );
    xlim([-p.sampleRate/4 p.sampleRate/4]);
    xlabel('Hz');
    ylabel('dB');
end

%% save and close figure
saveas(gcf, [path fileName], xts);
close;

end
