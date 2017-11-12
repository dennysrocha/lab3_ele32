function [ output_args ] = Hamming( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[H,G,n,k] = hammgen(3);

for p=0.01:0.01:0.5
    errors = 0;
    for i=1:250000
        data = randi([0 1],k,1)';
        %encData = encode(data,n,k,'hamming/binary');
        encData = mod(data*G,2);
        for j=1:7
            if rand(1,1)<=p
                encData(j) = ~encData(j);
            end;
        end;
        syndrome = mod(encData*H',2);
        for ii=1:n
            e = zeros(1,n);
            e(ii) = 1;
            error = mod(e*H',2);
            decData = encData;
            if error==syndrome
                decData = mod(encData+e,2);
                break;
            end;
        end;
        errors = errors + biterr(data,decData(4:7));
    end;
    fileID = fopen('data1000000.txt','a+');
    fprintf(fileID,'%f %f\r\n',p,errors/1000000);
    fclose(fileID);
    
end;

end

