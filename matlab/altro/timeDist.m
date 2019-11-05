function timeDist = timeDist(p, times)
% Counts prediction errors


signal      = p.signal( end, : );
N           = 1 : 1 : size(signal,2);
M           = length(times);


[signal, ind]      = sort(p.signal( end, : ), 'asc');
% signal( 1,end-M + 1 : end );
timeDist = sum( abs( sort( ind(1,end-M + 1 : end) ) - sort( times ) )) / M;
timeDist = timeDist / p.sampleRate * 1000;


end