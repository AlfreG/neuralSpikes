function graphSpectr( p )
% Plot DFTs of signal against filters



% Get interspike times type
interTimes = p.interSpikeType;


% Spike train with causal inter spike times
[signalR, impulseParam] = spikeTrain(p, false);

% Spike train with constant inter spike times
p.interSpikeType = 3;
[signalC, ~] = spikeTrain(p, false);
p.interSpikeType = interTimes;

% Add noise
signalN = signalR + thermalNoise(p, impulseParam);

% Mean signal C
% signalC = mean( signalC, 1);
signalC = signalC(1,:);


% Normalize signals
signalN = (signalN - mean( signalN, 2))./ std( signalN, [], 2);
signalC = (signalC - mean( signalC, 2))./ std( signalC, [], 2);


% Reference psd: first pixel arithmetic mean of reference signal
s1 = myFilter(signalN, p, 1);
s2 = myFilter(signalN, p, 2);
s3 = myFilter(signalN, p, 3);
s4 = myFilter(signalN, p, 4);

psdString = "psd";
outR = myDft(signalC(1,:), p, psdString);
outN = myDft(signalN(1,:), p, psdString);
out1 = myDft(s1, p, psdString);
out2 = myDft(s2, p, psdString);
out3 = myDft(s3, p, psdString);
out4 = myDft(s4, p, psdString);

index = (p.nyquist+2 : p.nyquist+p.spikeRate*4 );
cM = corr([outR(index)' out1(index)' out2(index)' out3(index)' out4(index)']);
cM(1,2:end);



close; hold on;
plot( p.freq, outR, 'k-', 'LineWidth', 2 ) ;
plot( p.freq, outN, 'r-.' ) ;
plot( p.freq, out1, 'b--' );
plot( p.freq, out2, 'c--' );


grid ON;
%         title( 'PSD. ' + string(p.impulseLabel(p.impulseType)) + '. ' + num2str(p.snrDb) + 'dB' );
legend('Reference Signal PSD. ' + string(p.impulseLabel(p.impulseType)), ...
       'Noisy Signal PSD', ...
       'BP.filt+arith.Mean', ...
       'BP.filt+square.Mean', ...
       'Orientation','vertical');
 
xlabel('Hz');
ylabel('dB(V^2/Hz)');
xlim([0 3000]);
ylim([-200 -20]);
xticks(p.spikeRate*(0:1:20));

text( p.spikeRate, -200, 'spikeRate: '+ string(p.spikeRate) + 'Hz. ' + 'SNR: ' + string(p.snrDb)  );
set(gcf,'WindowStyle','docked');
        
saveGraph(p);

end


%-------------------------------------------------------------------------
function saveGraph(p)

if p.saveGraph == true
    
    % Global graphical settings
%     set(0,'DefaultAxesFontName','arial');
%     set(0,'DefaultAxesFontSize',11);
% 
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [-7.5171; 6.145; 18; 26 ]);
        
    sect = ['I' num2str(p.impulseType) 'SNR' num2str(p.snrDb)];
    desc = 'spec';
    fileName = [sect desc];
    path = p.path;

    
    % save and close figure
    saveas(gcf, [path fileName], 'jpg');
    saveas(gcf, [path fileName], 'epsc');
    saveas(gcf, [path fileName], 'fig');
    close;
    

end
end