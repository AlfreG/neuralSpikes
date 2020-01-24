M = zeros(2,9);

for i = 2:1:5
    [B, A] = butter(i, [0.1 0.2],'stop');
    M(1,i-1) = length(B);
    M(2,i-1) = length(A);
end

M
