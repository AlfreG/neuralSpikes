function firTF(order,sampleRate)
% Unnormalized FIR impulse response functions of n orders
% for SIGNAL and SQUARED SIGNAL
% -- with no inputs defaults values are used


if nargin == 0 % default test input parameters
    order = 3;
    sampleRate = 9*1e3; % sample Rate in Hz
end

theta =(0:0.01:pi); 
z = exp(1i*theta'*order);

subplot(2,1,1),
plot(theta*sampleRate/2/pi, abs(cumsum(z,2)));
    grid on;
    title('Unnormalized fir-n transfer function','fontsize',10);
    text('string','$y_{n} = \sum_{k=0}^{N} x_{n-k}$',...
                 'interpreter','latex',...
                 'fontsize',13,...
                 'units','norm',...
                 'pos',[0.3 0.90])
    xlabel('Hz');
    ylabel('');


z = exp(1i*theta'.*n*2);
subplot(2,1,2),
plot(theta*sampleRate/2/pi, abs(cumsum(z,2)));
    grid on;
    title('Unnormalized fir-n transfer function','fontsize',10);
    text('string','$y_{n} = \sum_{k=0}^{N} x_{n-k}^2$',...
                 'interpreter','latex',...
                 'fontsize',13,...
                 'units','norm',...
                 'pos',[0.3 0.90])
    xlabel('Hz');
    ylabel('');

end
