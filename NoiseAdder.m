function [w_noised] = NoiseAdder(w,p)
% w � a palavra-c�digo sem adi��o de ru�dos
% p eh a probabilidade de ru�dos do canal
% w_noised � a palavra c�digo com adi��o de ru�dos
%
%% DESCRI��O DO C�DIGO
%  
%   fazer um loop de 24 itera��es que ir�:
%       gerar um n�mero aleat�rio entre 0 e 1
%       se esse n�mero for menor que p, o inverteremos (0 vira 1 assim como
%       1 vira 0)
%
%% C�DIGO

for i=1:24
    w_noised(i) = w(i);
    number = rand(1,1);
    if number<=p
        w_noised(i) = mod(w(i)+1,2);
    end;
end;

end

