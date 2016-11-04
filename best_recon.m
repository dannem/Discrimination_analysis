%% looking for the best reconstruciton
%% preparing data
load('/psyhome/u6/nemrodov/Discrimination/ERP_all_13_mean_ncl.mat');
load('/psyhome/u6/nemrodov/EEG_Reconstruction/ims_mixed.mat')
name=['/psyhome/u6/nemrodov/EEG_Reconstruction/Results/'];
data=output_same_uw([60:62 64],:,:,:);
% data=output_same_uw;
imNum=size(data,2);
elc=size(data,1);
tbins=size(data,4);
data= permute(data,[4 1 2 3]);
% data=reshape(data,size(data,1)*size(data,2),imNum,size(data,4));
data=data(1:500,:,:,:);
data=reshape(data,5,100,4,120,16);
data=permute(data,[1,3,4,5,2]);
data=reshape(data,20,120,16,100);

data=normOneRange(data);
data=reshape(data,tbins,elc,imNum,16);
data= permute(data,[2 3 4 1]);

%% computing cum discrimination 
filename=['SVM_cum_all_13'];
[output_disc_across,perm_mat] = runSVM(output_same_uw,id_num,c);
time=toc; 

%%
bck=ell(:);
bck=find(bck==0);
ims=ims([1:54 61:114]);
id_num=imNum/2;
c=1;

%% computing conf matrix
count=1;
for i=200:100:1000
    % ica
    [output_same_uw] = fastica (data, 'lastEig', i, 'numOfIC', i);
    feat=size(output_same_uw,1);
    % normalization
    output_same_uw=reshape(output_same_uw,size(output_same_uw,1)*imNum,16);
    output_same_uw=normOneRange(output_same_uw);
    output_same_uw=reshape(output_same_uw,feat,imNum,16);
    % discrimination
    [output_disc_within,~] = runSVM_same_emot(output_same_uw,id_num,c);
    % confusibility matrix
    conf_happ_all_features_all_ids = squareform(squeeze(output_disc_within.ap(1,1,:)));
    conf_neut_all_features_all_ids = squareform(squeeze(output_disc_within.ap(1,2,:)));
    % reconstruction
    subjNum=['all_13_54_ica_norm_' num2str(i) '_happ'];
    pipeline_short(bck,conf_happ_all_features_all_ids,ims,name,subjNum,20,1000,20,0.1);
    subjNum=['all_13_54_ica_norm_' num2str(i) '_neut'];
    pipeline_short(bck,conf_neut_all_features_all_ids,ims,name,subjNum,20,1000,20,0.1);
    
    % normalized pca
    % pca
    [coeff, ~] = pca(data');
    reducedDimension = coeff(:,1:i);
    output_same_uw= data' * reducedDimension;
    feat=size(output_same_uw,2);
    % nomoalizing
    output_same_uw=reshape(output_same_uw',size(output_same_uw,2)*imNum,16);
    output_same_uw=normOneRange(output_same_uw);
    output_same_uw=reshape(output_same_uw,feat,imNum,16);
    % svm
    [output_disc_within,~] = runSVM_same_emot(output_same_uw,id_num,c);
    % confusibility matrix
    conf_happ_all_features_all_ids = squareform(squeeze(output_disc_within.ap(1,1,:)));
    conf_neut_all_features_all_ids = squareform(squeeze(output_disc_within.ap(1,2,:)));
    % reconstruction
    subjNum=['all_13_54_pca_norm_' num2str(i) '_happ'];
    pipeline_short(bck,conf_happ_all_features_all_ids,ims,name,subjNum,20,1000,20,0.1);
    subjNum=['all_13_54_pca_norm_' num2str(i) '_neut'];
    pipeline_short(bck,conf_neut_all_features_all_ids,ims,name,subjNum,20,1000,20,0.1);    
end
poolobj = gcp('nocreate');
delete(poolobj);

%deleting finished jobs from the job monitor
c = parcluster('default_jobmanager')
finished_jobs = findJob(c,'State','finished','Username','nemrodov')
delete(finished_jobs)
