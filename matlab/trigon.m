N = 1000;
t = (1:1:N)*8*pi/N;

x = t + 2*rand(1,1000);
y = 10*sin(sqrt(2)*t) + 5*rand(1,1000);

% circonferenza trigonometrica
plot3(x,y,t)
%     line( sqrt(2)*[0 0.5], sqrt(2)*[0 0.5], 'Color', 'k');
    
    
grid on
xlabel('x');
ylabel('y');
zlabel('tempo');
    
