function [codigoDecodificado, retransmitir] = GolayDecoder(w)
% w eh a palavra-código ja com adição de ruídos
% codigoDecodificado é o código estimado
%
%% DESCRIÇÃO DO CÓDIGO
%
%   criar as matrizes A e H
%
%   computar a sindrome s:
%       s = mod(codigoRecebido*G^T, 2)
%   se o peso de hamming de s for maior ou igual a 3:
%       u = [s,0 0 0 0 0 0 0 0 0 0 0 0]
%   se o peso de hamming for maior que 3 mas, para valores
%   de i = 1,2,...,12, o peso de s+A_i for menor ou igual a 2:
%       u = [s+A_i, e_i]
%           onde e_i eh a i-esima coluna da I12
%   computar a sindrome s2:
%       s2 = s*A
%   se o peso de hamming de s2 for menor ou igual a 3:
%       u = [0 0 0 0 0 0 0 0 0 0 0 0, s2]
%   se o peso de s2 for maior que 3 mas, para valores de 
%   i = 1,2,...,12, o peso de s2+A_i for menor ou igual a 2:
%       u = [e_i,s2+A_i]
%   se u ainda nao estiver determinado, solicite retransmissao
%
%% Gerando as matrizes A e H

retransmitir = 0;

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
H = G';                         % define matriz H
J = ones(12,1);                 % cria matriz coluna 12x1 com '1'


%% CÓDIGO
% calcula a primeira síndrome e, a partir dela, toma decisões dependendo do
% seu peso

s1 = mod(w*H,2);                % calcula a primeira sindrome
ns1 = s1*J;                     % calcula peso da primeira sindrome


% caso o peso da primeira síndrome seja menor que três, o código está
% determinado
if ns1<=3
    u = [s1,zeros(1,12)];
    v = mod(w+u,2);
    codigoDecodificado = v(1:12);
end;

% caso o peso da primeira síndrome seja maior que três, continuam-se os
% calculos
if ns1>3
    S1 = J*s1;
    R1 = mod(S1+A,2);
    nr1 = (R1*J)';
    aux = 0;
    % caso o peso de s+A_i seja menor que 2 para algum i = 1,2,...,12, o
    % código está determinado
    for i=1:12
        if nr1(i)<3
            aux = 1;
            u = [mod(R1(i,:),2),I(i,:)];
            v = mod(w+u,2);
            codigoDecodificado = v(1:12);
            break;
        end;
    end;
    % caso o peso de s+A_i seja maior que 2 para todos i = 1,2,...,12,
    % continuam-se os cálculos:
    if aux==0
        s2 = mod(s1*A,2);                   % calcula a segunda síndrome
        ns2 = s2*J;                         % calcula o peso da segunda
                                            % síndrome
        % caso o peso da segunda síndrome seja menor ou igual a três, o
        % código está determinado
        if ns2<=3
            u = [zeros(1,12),s2];
            v = mod(w+u,2);
            codigoDecodificado = v(1:12);
        % caso o peso da segunda síndrome seja maior do que três,
        % continuam-se os cálculos
        else
            S2 = J*s2;
            R2 = mod(S2+A,2);
            nr2 = (R2*J)';
            aux2 = 0;
            % caso o peso de s+A_i seja menor que 2 para algum
            % i = 1,2,...,12, o código está determinado
            for i=1:12
              if nr2(i)<3
                aux2 = 1;
                u = [I(i,:),mod(R2(i,:),2)];
                v = mod(w+u,2);
                codigoDecodificado = v(1:12);
                break;
             end;
            end;
            % caso o peso de s+A_i seja maior que 2 para algum
            % i = 1,2,...,12, é necessário pedir retransmissão da mensagem
            if aux2==0
                codigoDecodificado = w(1:12);
                retransmitir = 1;
            end;
        end;
    end;
end;


end

