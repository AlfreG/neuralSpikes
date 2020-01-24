function [ q0, v0 ] =  apTreshold(sigma)

% let b the probability that n gaussian distribution with 0 mean
% and variance sigma(i) be all together greater than a  
% threshold v0:
%
% Prob { | X(i) | > v0, for all i } = b, then
% Prob { sum(| Z(i) |^2) > sum(|v0/sigma(i)|^2), for all i } = b
%
% where Z(i) are indipendent and identically distributed 
% standard normal with o mean and 1 variance,
%
% now Q = sum(| Z(i) |^2) is a chisquare probability distribution
% with n degree of freedom, or equivantely, a gamma probability
% distribution with a shape parameter alpha = n/2 and a scale parameter beta = 1/2.
% And let q0 = sum(|v0/sigma(i)|^2)
%
% Prob { Q > q0 } = b
%
% and v0 = sqrt(q0)/sigma, where sigma is now the harmonic mean of
% sigma(i), i = 1 ... n.

b = 6.25 * 1e-10;           % probability upper threshold
n = length(sigma);          % pixels in hexagonal grid

q0 = chi2inv( 1-b, n);
q0 = sqrt(q0);
v0 = q0 * sum(1./sigma);
    
end


% this is a probability distribution:
% syms x;
% double(int( 2*(x^(20))*exp(-x^2), 0, 1e15))/ gamma(21/2)
%
% here we obtain M. Reatto's result:
% double(int( 2*(x^(20))*exp(-x^2), 6.57932, 1e15))/ gamma(21/2)
% which is the same:
% double(int( 1*(x^((21/2)-1))*exp(-x), (6.57932)^2, 1e15))/ gamma(21/2)
% 