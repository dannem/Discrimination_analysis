%%%original matrix: conditions(images) X time X block
%%%reshaped as: time x condition x block x area (or electrodes)
%%%area order : la,lp,ra,rp
%%
clear Data
clear Data_reshape
clear Data_reshape_in
clear Data_reshape_negout
clear Data_reshape_norm
clear Data_reshape_posout
clear Data_reshape_zed

DataMat=permute(DataMat,[2,1,3,4]);
for i=1:size(DataMat,4)
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

clear Data
clear Data_reshape
clear Data_reshape_in
clear Data_reshape_negout
clear Data_reshape_norm
clear Data_reshape_posout
clear Data_reshape_zed
clear i
