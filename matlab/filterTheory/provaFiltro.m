function provaFiltro(p,u)

[B, A] = butter(p.filterOrder, 2*p.cutOffFreq/p.sampleRate,p.filterType);

[H,W] = freqz(B,A);

[Z,P,G] = tf2zp(B,A);

fvtool(B,A)

plot(H)

end