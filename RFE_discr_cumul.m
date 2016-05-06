function [output,feat_num] =RFE_discr_cumul(data,rfe_output,batchSize,idNum,c_crt) 
%% This function computes discrimination based on n cummulative bins of features
% input:    data - ERP data (features X ids+emotions X blocks)
%           rfe_output - output of RFE_SVM.m function (features X ids pairs X emotions) 
%           batchSize - how many features are added at each step (scalar)
% output:   output - discrimination
%           feat_num - number of features included in the step

%% checks
if nargin<5
    c_crt=1;
end
numFeat=size(data,1);
if numFeat~=size(rfe_output,1)
    error('The number of features in the ERP data file does not correspond to the rfe array size')
elseif rem(numFeat,batchSize)~=0
    disp('The batch size does not allow even number of features in each batch')
end
combos = nchoosek([1:idNum],2);
numBatch=ceil(numFeat/batchSize);
rfe=squeeze(mean(rfe_output,2));
[~,indEm1]=sort(rfe(:,1));
[~,indEm2]=sort(rfe(:,2));
for k=0:numBatch-38
    ind_curr=1:batchSize+k*batchSize;
    feat_num(k+1)=length(ind_curr);
    ind1=indEm1(ind_curr);
    ind2=indEm2(ind_curr);
    temp1=data(ind1,:,:);
    temp2=data(ind2,:,:);
    k
    for j=1:2
        parfor i=1:size(combos,1)
            [ap, d, ~]=apply_classf_libsvm_new(temp1,combos(i,:),j,c_crt);
            ap1(i)=ap;
            d1(i)=d;
            [ap, d, ~]=apply_classf_libsvm_new(temp2,combos(i,:),j,c_crt);
            ap2(i)=ap;
            d2(i)=d;
        end
        output.d2(k+1,j,:)=d2;
        output.ap2(k+1,j,:)=ap2;
        output.d1(k+1,j,:)=d1;
        output.ap1(k+1,j,:)=ap1;
    end
end

    

