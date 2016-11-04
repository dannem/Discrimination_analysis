function [output]=norm_oulier_cap(input);
if iscell(input)
output=cell(size(input));
for i=1:size(output,1)
    for j=1:size(output,2)
        temp=input{i,j};
        temp(temp>3)=3;
        temp(temp<-3)=-3;
%         for z=1:size(temp,1);
%             for k=1:size(temp,3)
%                 temp1=squeeze(temp(z,:,k));
%                 temp1=temp1/(max(abs(temp1(:)))*2);
%                 temp1=temp1+0.5;
%                 temp(z,:,k)=temp1;
%             end
%         end
        output{i,j}=temp;
%         Data_reshape_norm=(temp/6)+0.5; % scale to 0-1 and fix outs next
%         Data_reshape_posout=Data_reshape_norm>1;
%         Data_reshape_negout=Data_reshape_norm<0;
%         Data_reshape_in=~Data_reshape_posout & ~Data_reshape_negout;
%         output{i,j}=Data_reshape_norm.*double(Data_reshape_in)+double(Data_reshape_posout); %replace max outs w/ 1, leave min ones as 0
    end
end
else
    for i=1:size(input,2)
        for j=1:size(input,3)
            for k=1:size(input,4)
                temp=squeeze(input(:,i,j,k));
                temp=zscore(temp);
                temp=temp./repmat(max(abs(temp)),size(temp,1),1);
                temp=(temp+1)/2;
                output(:,i,j,k)=temp;
            end
        end
    end
end
    