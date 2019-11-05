function graphDSPWhiteNoise(p, plotTF)

p.sampleRate=9000;
p.offset=0;
p.snrDb=5;
p.amplitudeLowFreq=0;
p.amplitudeHighFreq=0;
p.samplesNumber=1024;
p.noiseTF=true;
p.saveGraph=false;

chap = '5'; 
sect = '15';
desc = 'DSPwhite';
fileName = [chap sect desc];
xts = 'epsc';
path = 'graph/';


signal = mySignal(p,false);

%[B, A] = butter(p.filterOrder, 2*p.cutOffFreq/p.sampleRate,p.filterType);

%filteredSig = filter( B, A, signal );





if plotTF == 1
size = p.samplesNumber;
timeScaling = 1000/p.sampleRate; % ms

subplot(2,1,1), % time domain 
    plot( (1:size)*timeScaling, signal );
    grid ON;
    legend( 'white noise' );
    title( [  ...
             %' lowFreq = '      num2str(p.lowFreq)  'Hz;'  ...
             %' HighFreq = '     num2str(p.highFreq) 'Hz;'  ...
             ' samples = '      num2str(size)       ';'     ...
             'sampleRate = '    num2str(p.sampleRate/1000) 'kHz;' ...
             ' snr = '          num2str(p.snrDb)    'dB;'   ...
             ' offset = '       num2str(p.offset)   'V'     ...             
             ] );
    xlim([ 0 p.sampleRate/(p.highFreq-p.lowFreq) ]);
    xlabel('ms');
    ylabel('V');

   
subplot(2,1,2), % frequencies domain

    plot( periodogram(signal) ); hold on;
  
    %frequencies = p.sampleRate*(-size/2:1:size/2-1)'/size;
 
    signalDb        = 20*log10( abs( sfft( signal )));
    signalDb        = 2*signalDb - 20*log10(size);
    %signalDb        = (abs( sfft( signal )).^2)/size;
    %filteredSigDb  = 20*log10(abs(sfft( filteredSig )));
    %transferFunc   = 20*log10(abs(freqz(B, A, frequencies, p.sampleRate)));
    
    %plot( frequencies,     signal );
    %plot(signalDb(size/2:end));

    grid ON;
    title([  'Densità spettrale di potenza'  ...
             %' fOrder = '        num2str(p.filterOrder) ...
             %' cutoffFreq = '    num2str(p.cutOffFreq) ...
             '' ...
             ]);
    %legend(  'signal' );
    %xlim([-p.sampleRate/4 p.sampleRate/4]);
    %xlim([0 p.sampleRate/4]);
    %xlabel('Hz');
    %ylabel('dB');
end


%% save and close figure
if p.saveGraph == true
    saveas(gcf, [path fileName], xts);
    close;
end

end
