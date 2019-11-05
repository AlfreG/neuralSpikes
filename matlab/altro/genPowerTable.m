function genPowerTable(p)

pixels = p.pixelNumber;
trasformationNumber = size(p.filter, 1);
sampleSize = p.sampleDuration * p.sampleRate;
rows = 1 + pixels*[ 0 trasformationNumber-1 ] - [0 1];
y = p.dft(rows,:);
filter = ['sign'; 'filt';'\pm%'];
switch p.algorType
    case 'simpleAv'
        alg = ['s'; 's'; 's'];
    case 'quadratic'
        alg = ['q'; 'q'; 'q'];
    case 'pca'
        alg = ['p'; 'p'; 'p'];
end

% belowBand = [ num2str(0)          '-' num2str(p.lowFreq)  'Hz' ];
% inBand    = [ num2str(p.lowFreq)  '-' num2str(p.highFreq) 'Hz'];
% topBand   = [ num2str(p.highFreq) '-' num2str(p.sampleRate/2) 'Hz' ];

[power, powerTot] = powerBand( y, p.lowFreq, p.highFreq, sampleSize, p.sampleRate);
power    = [power;    (power(2,:)-power(1,:))./power(1,:)*100 ];
powerTot = [powerTot; (powerTot(2,:)-powerTot(1,:))./powerTot(1,:)*100 ];
power = round( power, 4 );
powerTot = round( powerTot, 4 );



T = table( filter, alg,  power(:,1), power(:,2), power(:,3), powerTot );
T.Properties.VariableNames = {'Filter'; 'Alg'; 'lowBand'; 'Band'; 'topBand'; 'TotPowersize'};
T.Properties.Description = 'Distribuzione potenza segnale';
T.Properties.VariableUnits = {''; '';'V^2 ohm'; 'V^2 ohm'; 'V^2 ohm'; 'V^2 ohm' };

T

% T = table2latex(T);

% save latex table
% fileID = fopen([path fileName '.tex'],'w');
% fprintf(fileID,caption);
% fclose(fileID);

end