function [] = DataManager()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for p=0.005:0.005:0.5
    Golay(p,10);
    p
    ' 10'
    Golay(p,100);
    p
    ' 100'
    Golay(p,1000);
    p
    ' 1000'
    Golay(p,10000);
    p
    ' 10000'
end; 

end

