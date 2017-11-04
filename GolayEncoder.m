function [w] = GolayEncoder(code)
% code eh o código original, sem ruídos
% w eh a palavra-código, sem ruídos
%
%% DESCRICAO DO CODIGO
%
%   criar a matriz G
%
%   com a matriz G, gerar a palavra-codigo
%
%%

I10 = eye(10);                  % cria uma identidade 10x10
Z10 = zeros(1,10);              % cria matriz linha 1x10 com '0'
P = [Z10 1; I10 Z10'];          % matriz auxiliar
x = [1 1 0 1 1 1 0 0 0 1 0];    % vetor auxiliar
for i = 1:11,
    A11(i,1:11) = [x*P^(i-1)];  
end;                            % matriz auxiliar

I = eye(12);                    % cria identidade 12x12
J11 = ones(11,1);               % cria matriz coluna 11x1 com '1'
A = [A11 J11; J11' 0];          % define matriz A


G = [I A];                      % define matriz G
w = mod(code*G,2);

end

