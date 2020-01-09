N = 100;
t = (1:1:N)*4*pi/N;

x = cos(1.2*t);
y = sin(2*t);

% 3D plot trajectory
plot3(t, y,x)
    % line( sqrt(2)*[0 0.5], sqrt(2)*[0 0.5], 'Color', 'k')
    grid on
    xlabel('x');
    ylabel('x');
    
