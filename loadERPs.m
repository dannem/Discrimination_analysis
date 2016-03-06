%loading data from lwdata
temp=lwdata;
for i=1:size(temp,2)
    data(:,:,:,i)=squeeze(temp(i).data);
end

% DataMat=cat(4,dataH,dataN);
DataMat=permute(data,[4 2 1 3]);
% DataMat=DataMat(:,:,:,138);
size(DataMat)

DataMat=out;%from aggrERP.m
newData=NaN(size(DataMat));
for i=1:size(DataMat,1)/2
    newData(i*2-1,:,:,:)=DataMat(i+size(DataMat,1)/2,:,:,:);
    newData(i*2,:,:,:)=DataMat(i,:,:,:);
end
DataMat=newData;

DataMat=permute(DataMat,[3,1,2,4]);% from aggrERP
% DataMat=permute(DataMat,[2,1,3,4]); %from lwdata
for i=1:size(DataMat,4) % needs to be el X im X bl X time. zscoring over im x blocks
    Data=squeeze(DataMat(:,:,:,i));
    
    Data_reshape=reshape(Data(:,:,:), size(Data, 1), size(Data, 2)*size(Data, 3));
    Data_reshape_zed=zscore(Data_reshape, 0, 2);
    Data_reshape_norm=(Data_reshape_zed/6)+0.5; % scale to 0-1 and fix outs next
    
    Data_reshape_posout=Data_reshape_norm>1;
    Data_reshape_negout=Data_reshape_norm<0;
    Data_reshape_in=~Data_reshape_posout & ~Data_reshape_negout;
    
    Data_reshape_norm=Data_reshape_norm.*double(Data_reshape_in)+double(Data_reshape_posout); %replace max outs w/ 1, leave min ones as 0
    DataMat(:,:,:,i)=reshape(Data_reshape_norm, size(Data, 1), size(Data, 2), size(Data, 3));
end
% size = el X im X block X time
clear Data newData
clear Data_reshape
clear Data_reshape_in
clear Data_reshape_negout
clear Data_reshape_norm
clear Data_reshape_posout
clear Data_reshape_zed
clear i
