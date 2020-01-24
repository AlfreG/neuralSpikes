signal = zeros(1,100);
signal(1, 40:45) = sin((1:1:6));

subplot(3,1,1),     plot(signal);
subplot(3,1,2),     plot(abs(sfft(signal)));
subplot(3,1,3),     plot(abs(sfft(signal.^2)));
