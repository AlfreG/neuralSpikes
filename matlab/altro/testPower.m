function testPower( lowMean, highMean, var, N )
% 

if nargin ==0
    lowMean = 0;
    highMean = 1;
    var = 1;
    N = 9;
end

step = 3*1e5;
tres = linspace(-3*highMean, 3*highMean, step );
win = 10;

alfa = normcdf(tres, lowMean, var, 'upper').^N;
beta = ones(1,step) - normcdf(tres, highMean, var, 'upper').^N;
[zero, index] = min( abs(alfa-beta) );

subplot(3,1,1),      plot(tres, [alfa; beta] )
        grid ON;
        title('Ampiezze di errore. Test congiunto');
        legend( 'alfa', 'beta', 'Location', 'northeast');
        xlabel('soglia test [V]');
        ylabel('Prob');
        xlim([ tres(index-win) tres(index+win)]);    

alfa = normcdf(tres, lowMean, var/N, 'upper');
beta = ones(1,step) - normcdf(tres, highMean, var/N, 'upper');
[zero, index] = min( abs(alfa-beta) );

subplot(3,1,2),      plot(tres, [alfa; beta] )
        grid ON;
        title('Ampiezze di errore. Test media');
        legend( 'alfa', 'beta', 'Location', 'northeast');
        xlabel('soglia test [V]');
        ylabel('Prob'); 
        xlim([ tres(index-win) tres(index+win)]);
    
        
        
alfa = chi2cdfMean(tres, N, lowMean);
beta = ones(1,step) - chi2cdfMean( tres, N, highMean );
[zero, index] = min( abs(alfa-beta) );

subplot(3,1,3),      plot(tres, [alfa; beta] )
        grid ON;
        title('Ampiezze di errore. Test chi2');
        legend( 'alfa', 'beta', 'Location', 'northeast');
        xlabel('soglia test [V]');
        ylabel('Prob');
        xlim([ tres(index-win) tres(index+win)]);
    
        
        
end


function p = chi2cdfMean( x, n, mean )

N = 1e5;
M = length(x);
y = sum( (randn(n, N) + mean ).^2, 1)./n;
y = sqrt(y);
p = zeros(1,M);


for j = 1:M
p(j) = length( y( y>x(j) ) )./N;
end

end













