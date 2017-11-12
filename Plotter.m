function [] = Plotter()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fileBegin = 'data';
fileEnd = '.txt';

file = [];
file = strcat(fileBegin,int2str(1000000));
file = strcat(file,fileEnd);
data = fopen(file);
dataRead = textscan(data,'%f %f',50);
fclose(data);
x = dataRead{1};
%for i=1:50
%    x(i) = (erfcinv(2*x(i)))^2;
%end;
y = dataRead{2};
xx = 0:.005:0.5;
yy = pchip(x,y,xx);
plot(xx,yy,'r');
set(gca, 'XDir','reverse')
grid on
box on
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
hold on

fileBegin = 'data';
fileEnd = '_1.txt';

file = [];
file = strcat(fileBegin,int2str(1000000));
file = strcat(file,fileEnd);
data = fopen(file);
dataRead = textscan(data,'%f %f',50);
fclose(data);
x = dataRead{1};
%for i=1:50
%    x(i) = (erfcinv(2*x(i)))^2;
%end;
y = dataRead{2};
xx = 0:.005:0.5;
yy = pchip(x,y,xx);
plot(xx,yy,'b')
set(gca, 'XDir','reverse')
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

y=x;
xx = 0:.005:0.5;
yy = pchip(x,y,xx);
plot(xx,yy,'k')
set(gca, 'XDir','reverse')
set(findall(gca, 'Type', 'Line'),'LineWidth',2);

hold off

title('Gráfico de comparação entre códigos de correção de erros');
xlabel('probabilidade p');
ylabel('BER (taxa de erro de bits)');
legend('Hamming (7,4,3)','Golay (24,12,8)','Não codificado','Location','northeast');
end

