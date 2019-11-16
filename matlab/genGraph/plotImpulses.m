function plotImpulses(p)

hold on; 
p.pixelNumber = 10;
p.waveVelocity = 10;
p.pixelDistance = 5;
p.impulseType = 5;


impulse = impulseSampling( p );
meanPower = impulsesMeanPower(impulse(1,:), p);


mesh(impulse);
    legend(string(meanPower*1e6) + '\muW');
    ylabel('space [\mu m]');
    xlabel('time [ms]')
    zlabel('Tension [V]')
    grid on;
    view(5, 61);

end


function meanPower = impulsesMeanPower(impulse, p)

    meanPower = mean( sum(impulse.^2, 2) ) / p.sampleRate; % V^2s

end