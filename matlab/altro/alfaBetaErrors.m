function errors = alfaBetaErrors(p, times)
% Counts prediction errors


signal      = p.signal( end, : );
N           = 1 : 1 : size(signal,2);
M           = length(times);
minSpike    = min( abs(signal(times)) );                % lowest spike
maxNoise    = max( abs(signal( setdiff(N,times) ) ) );  % highest noise


% False positive count
alfas = sum( signal >= minSpike ) - length(times);

% True negative
betas = sum( signal(times)<= maxNoise );

errors = [alfas betas];


end