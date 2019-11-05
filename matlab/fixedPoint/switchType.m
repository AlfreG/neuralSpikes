function T = switchType(type)

% T rappresenta un intero binario a 16 bit senza segno
B = numerictype;
    B.DataTypeMode   = 'Fixed-point: binary point scaling';
    B.DataType       = 'Fixed';
    B.Signed         =  false;
    B.WordLength     = 16;
    B.FractionLength = 0;

% contiene le sue proprietà aritmetiche
F = fimath;
    F.CastBeforeSum = true; % Whether both operands are cast to the sum data type before addition
    F.ProductMode   = 'KeepMSB'; % {FullPrecision, KeepLSB, KeepMSB, SpecifyPrecision}
    F.SumMode       = 'KeepMSB'; %            
    

  switch type
    case 'double'
      T.b = double([]);
      T.x = double([]);
      T.y = double([]);
      T.d = double([]);

     case 'fixed16'
      T.b = fi([],B,F);
      T.x = fi([],B,F);
      T.y = fi([],B,F);
      T.d = double([]);
  end
end

% prove di casting
% b = 4.2;
% T = switchType('fixed16');
% b=cast(b,'like',T.b);
% b.bin
    
% sum
% Create a fixed-point number with specified signedness, word length, and fraction length
% You can specify the signedness (1 for signed, 0 for unsigned) and the word and fraction lengths
% a = fi( 1.5, 1,4,2);
% b = fi( 1   , 1,4,2);
% c = fi( 0.5, 1,4,2);
% a.bin
% b.bin
% c.bin


% multiplication
% grafico moltiplicazione 
% l = 3;
% a = -l:l;one
%text(num2str(reshape(a+a',(2*l+1)^2,1)))






% function b = base2( num, N, M, representation )

% returns for evry positive number less than 2
% the N binary representation:
% 's' -> sign magnitude
% '1' -> one's complement
% '2' -> two's complement


% if abs(num) >= 2
%     error(message('|input| must be less than 2'));
% end
% 
% b = zeros( N+M,1);
% 
% end


% NOTES:
% comunication toolbox
% dec2base
% num2bin
% de2bi
% bi2de