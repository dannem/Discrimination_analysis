function [output]=norm_oulier_cap(input);
output=cell(size(input));
for i=1:size(output,1)
    for j=1:size(output,2)
        temp=input{i,j};
        Data_reshape_norm=(temp/6)+0.5; % scale to 0-1 and fix outs next
        Data_reshape_posout=Data_reshape_norm>1;
        Data_reshape_negout=Data_reshape_norm<0;
        Data_reshape_in=~Data_reshape_posout & ~Data_reshape_negout;
        output{i,j}=Data_reshape_norm.*double(Data_reshape_in)+double(Data_reshape_posout); %replace max outs w/ 1, leave min ones as 0
    end
end
    