function [output] = Golay(p,len)
% essa é basicamente a funcão main, que recebe o arquivo .txt como entrada
% do canal e retorna outro .txt, que representa a saída do canal
% decodificada
% p eh a probabilidade de erro do canal
%
%% DESCRICAO DO CODIGO
%   lê-se o tamanho do input
%   com o tamanho n do input, faz-se n/12 iteracoes, onde cada iteracao
%   trata um vetor w de tamanho 12 criando sua palavra-codigo,
%   adicionando-o ao canal e decodificando a saida do canal
%
%% CODIGO
fileID = fopen('generatedBits.txt','w');
fprintf(fileID,'%d',randi([0 1],1,len));
fclose(fileID);
fileID = fopen('generatedBits.txt','r');
data = fread(fileID);
fclose(fileID);
for i=1:length(data)
    data(i)=data(i)-48;
end;
lmax = ceil(length(data)/12)*12;
lmin = length(data);
for k=length(data)+1:lmax
    data(k)=0;
end;
aux = [];
data = data';
for i=1:length(data)/12
    [code retransmitir] = GolayDecoder(NoiseAdder(GolayEncoder(data(12*(i-1)+1:12*(i-1)+12)),p));
    while retransmitir==1
        [code retransmitir] = GolayDecoder(NoiseAdder(GolayEncoder(data(12*(i-1)+1:12*(i-1)+12)),p));
    end;
    aux = [aux code];
end;

for i=1:lmin
    output(i) = aux(i);
end;

fileComparison = fopen('comparisonBits.txt','w');
fprintf(fileComparison,'%d',output);
fclose(fileComparison);

%% COMPARACAO ENTRE ARQUIVOS
fileGenerated = fopen('generatedBits.txt','r');
fileComparison = fopen('comparisonBits.txt','r');
generated = fread(fileGenerated);
comparison = fread(fileComparison);
fclose(fileGenerated);
fclose(fileComparison);

l = length(comparison);
errors = 0;

for i=1:l
    if generated(i)~=comparison(i)
        errors = errors+1;
    end;
end;
file = 'data';
string = int2str(len);
file = strcat(file,string);
file = strcat(file,'.txt');

dataPlot = fopen(file,'a+');

fprintf(dataPlot,'%f %f\r\n',p,errors/l);
fclose(dataPlot);

end
