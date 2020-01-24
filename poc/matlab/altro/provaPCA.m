%     [U,S,V] = svd(X) produces a diagonal matrix S, of the same 
%     dimension as X and with nonnegative diagonal elements in
%     decreasing order, and unitary matrices U and V so that
%     X = U*S*V'.


R = 1e1;
C = 1e1 ;
q = linspace(0,1,C);
x = ones(R,C).*q;

signal = magic(R);
signal = signal * signal';
dft    = abs(sfft(signal')); 
[u,s,v] = eig(x);
pca = u*s*v';

subplot(2,2,1),     plot(q, signal)
subplot(2,2,2),     plot(q, dft)
subplot(2,2,3),     bar(   diag(s) )
subplot(2,2,4),     plot(q, pca)




