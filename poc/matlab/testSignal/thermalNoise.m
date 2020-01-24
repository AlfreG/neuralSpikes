function noise = thermalNoise(p, impulseParam)
% Additive thermal noise. Sampling amplitude is computed according to
% SNR and total impulses power.

sampleSize = p.sampleSize;

% Add Noise
if p.noiseTF == true
    
    % Single impulse mean power SIMP
    mP = impulseParam.mP;
    % Signal total power: SIMP times number of impulses
    SP = mP * size(impulseParam.start,2);
    % Noise total power
    NP = SP * 10^( -p.snrDb / 10 );
    % noise sampling amplitude
    sigma = sqrt( NP / p.sampleDuration );
    
    noise  = randn( [ p.pixelNumber, sampleSize] ) * sigma; 

else
    noise  = zeros( p.pixelNumber, sampleSize );
end