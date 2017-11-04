function [w_noised] = NoiseAdder(w,p)
% w é a palavra-código sem adição de ruídos
% p eh a probabilidade de ruídos do canal
% w_noised é a palavra código com adição de ruídos
%
%% DESCRIÇÃO DO CÓDIGO
%  
%   fazer um loop de 24 iterações que irá:
%       gerar um número aleatório entre 0 e 1
%       se esse número for menor que p, o inverteremos (0 vira 1 assim como
%       1 vira 0)
%
%% CÓDIGO

for i=1:24
    w_noised(i) = w(i);
    number = rand(1,1);
    if number<=p
        w_noised(i) = mod(w(i)+1,2);
    end;
end;

end

