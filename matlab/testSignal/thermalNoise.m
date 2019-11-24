function noise = thermalNoise(p, impulseParam)
% Additive thermal noise. Sampling amplitude is computed according to
% SNR and total impulses power.

sampleSize = p.sampleSize;

% Add Noise
if p.noiseTF == true
    
    % single impulse mean power
    mP = impulseParam.mP;
    % impulse signal mean power: using actual impulse number
    mP = mP * size(impulseParam.start,2);
    % total length noise power
    noiseP = mP * 10^( -p.snrDb / 10 );
    % noise sampling amplitude
    sigma = sqrt( noiseP / p.sampleDuration );
    
    noise  = randn( [ p.pixelNumber, sampleSize] ) * sigma; 

else
    noise  = zeros( p.pixelNumber, sampleSize ); 


end