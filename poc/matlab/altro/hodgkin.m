a = 70;
b = 1;
c = 1;
d = 1;

F = @(t,y) [ y(2); -y(2)*b/a - y(1)*c/a - d/a  ];
y0 = [1; 0];

opts= odeset;

[t,y,tfinal] = ode45(F,[0 1024],y0,opts);

plot(t,y);