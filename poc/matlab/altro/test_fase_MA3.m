time = 1:1:1000;
signal = sin( 2*pi*0.3*time );
signal = signal + sin( 2*pi*0.01*time );
signal = signal + 0.1*randn([1,1000]);

B = [1 1 1]/3;
A = [1 0 0];
signalf = filtfilt( B, A, signal );

% signalf = filter( B, A, flip(signalf), [], 2 );
% y = [signal; flip(signalf)];

y = [signal; signalf];
y = y ./ std(y, [], 2);

plot(time, y)