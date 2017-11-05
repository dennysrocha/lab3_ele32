function [] = Plotter()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fileBegin = 'data';
fileEnd = '.txt';

for i=1:4
    file = [];
    file = strcat(fileBegin,int2str(10^i));
    file = strcat(file,fileEnd);
    data = fopen(file);
    dataRead = textscan(data,'%f %f',100);
    fclose(data);
    x = dataRead{1};
    y = dataRead{2};
    xx = 0:.05:0.5;
    yy = pchip(x,y,xx);
    plot(xx,yy)
    set(gca, 'XDir','reverse')
    grid
    
end;


end

