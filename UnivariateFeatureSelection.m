%% for Alex
load('/Users/dannem/Documents/Reconstruction/ERP_all_13_mean_ncl.mat')
%% fixing the data
data=output_same_uw(:,:,:,78:78+306);
els=size(data,1);
bins=size(data,4);
ids=size(data,2);
data= permute(data,[4 1 2 3]);
data=reshape(data,bins*els,120,16);
data=normOneRange(data);
data=mean(data,3);%features X ids
[output]=featureSlectionUni(data,1000,1:54,55:60);
all=output.all;
all=mean(all);
all=reshape(all,bins,els);
y=1:64;
x=linspace(50,650,bins); % 0 to 10 s, 1000 samples
% y=linspace(1,64,64);
figure
imagesc(x,y,abs(all)');
colorbar
% set(gca,'Yscale','log','Ydir','normal');

