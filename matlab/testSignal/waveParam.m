function waveParam(p)
% Calcolo parametri degli impulsi con riferimento quello gaussiano

if nargin == 0
    d = 1e-3;       % durata impulso gaussiano in [s]
    V = 60*1e-3;    % Picco impulso gaussiano in  [V]
else
    d = p.spikePeriod;
    V = p.amplitudeHighFreq;
end





A = d*sqrt(2)/3;            % [s]
A = A*1e3                   % [ms]
durataV = A*3/sqrt(2);      % [s]

areaV2 = V*V*A*sqrt(pi/2);   % [V^2 ms]
areaV2 = areaV2 *1e6;        % [(mV)^2 ms]

durataV2 = 3/A               % [kHz]

b = A*sqrt(pi/2);            % [ms]
b = b                        % [ms]
V2b = b*V*V *1e6             % [(mV)^2 ms]

snr = flip(1:1:10)';
sigma = [snr round(1e-3*sqrt(areaV2)*10.^(-snr/20), 3)] % [db - V]

end