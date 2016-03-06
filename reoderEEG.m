

% going over electrodes
clear DataMat
numIden=8;
numReg=length(lwdata)/numIden;
b=1;
for j=1:numReg
    for i=1:numIden
        da=squeeze(lwdata(b).data);
        DataMat(i,:,:,j)=reshape(da,size(lwdata(1).data,1),size(lwdata(1).data,2)*size(lwdata(1).data,6))';
        b=b+1;
    end
end

% showing effects over head
% input: lwdata from merged files. every lwdata index is image. epochs -
% blocks. File: lwdata_8_dim_23_66_1_1_1_101
% Output: images x times x blocks x electrodes
clear DataMat
for i=1:length(lwdata)
    da=squeeze(lwdata(i).data);
    DataMat(i,:,:,:)=permute(da,[3,1,2]);
end


% showing effects over time
% input: lwdata from merged files. every lwdata index is image. epochs -
% blocks. File: lwdata_8_dim_23_66_1_1_1_101
% Output: images x electrodes x blocks x time
%%
clear DataMat
for i=1:length(lwdata)
    da=squeeze(lwdata(i).data);
    DataMat(i,:,:,:)=permute(da,[2,1,3]);
end
clear da i