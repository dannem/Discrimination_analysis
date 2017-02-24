% familiarity discrimination
load('/Users/dannem/Documents/Reconstruction/ERP_all_13_mean_ncl.mat')
%% cumulative
data=output_same_uw([22:27 59:64],:,:,78:78+306);
data= permute(data,[4 1 2 3]);
data=reshape(data,size(data,1)*size(data,2),120,16);
data=normOneRange(data);
data=mean(data,3);%features X ids
output = run_SVM_Alex(data,1:54,55:60,1000);
mean(output.ac(:))
%% in time domain
data=output_same_uw([22:27 59:64],:,:,:);
elc=size(data,1);
for i=1:508
    temp(:,:,:,i)=cat(1,data(:,:,:,i),data(:,:,:,i+1),data(:,:,:,i+2),data(:,:,:,i+3),data(:,:,:,i+4));
end
for i=1:4
    temp(:,:,:,508+i)=temp(:,:,:,508);
end
data=temp;
data= permute(data,[4 1 2 3]);
data=reshape(data,512*elc*5,120,16);
data=normOneRange(data);
data=reshape(data,512,elc*5,120,16);
data= permute(data,[2 3 4 1]); %60   120    16   512
data=squeeze(mean(data,3));
for i=1:size(data,3)
    i
    output = run_SVM_Alex(squeeze(data(:,:,i)),1:54,55:60,1000);
    output_td.ac(i,:,:,:)=output.ac;
    output_td.at(i,:,:)=output.mat;
end
output_td.pair=output.pair;
mean_td=squeeze(mean(mean(output_td.ac,2),4));
figure
plot(linspace(-100,900,512),mean_td')
legend('Neutral to Happy','Happy to Neutral')