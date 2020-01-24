function filteredSignal = myFiltering(B, A, signal, init, form)
% Filters the signal given the parameter of the Z-trasform and initial condition.
% Filtering type: 'Direct1', 'Direct2'

N = length(signal);
n = length(init);
b = length(B);

filteredSignal =  zeros(N,1);

if form == '1'  % direct1  

    filteredSignal(1) = B(1)*signal(1) - [A(3) A(2)]*init'; 
    filteredSignal(2) = B(1)*signal(2) + B(2)*signal(1) -[A(3) A(2)]*[init(2) filteredSignal(1) ]';
    for i = 3:1:N
        filteredSignal(i) = -[A(3) A(2)]*filteredSignal(i-n:i-1) + [B(3) B(2) B(1)]*signal(i-b+1:i);
        filteredSignal(i) = filteredSignal(i);   %
    end
end


if form == '2'  % direct2

    w = zeros(3,1);

    for i = 1:1:N
        w(3) = -w(2)*A(2) - w(1)*A(3) + signal(i);
        filteredSignal(i) = B(3)*w(3) + B(2)*w(2) + B(1)*w(1);        
        w(1) = w(2);
        w(2) = w(3);
    end
end