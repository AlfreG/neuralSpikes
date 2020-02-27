snr = -25:1:-10;
mp = 1.43*1e-6;

SP = mp*150;
NP = SP * 10.^( -snr / 10 );
sigma = sqrt( NP / p.sampleDuration );

plot(snr, sigma);
grid on;
xticks(snr);
yticks(0.06*[0.25 0.5 0.75 1 1.25 1.5 2 3 4]);

xlabel('SNR [dB]', 'FontSize', 14);
ylabel('sigma [V]', 'FontSize', 14);