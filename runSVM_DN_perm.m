function [output,permMat] = runSVM_DN_perm(DataMat,idNum,numOfperm,cPar,timeBins)
%% This function computes SVM with permutations to assess significance.
% The input is a data file from eeg_preprocessing.m
% Inputs    DataMat:        4-D matrix (time: els X ims X bls X time)
%           idNum:          number of identities
%           numOfperm:      number of desired permutations
%           cPar:           c (criterion value for SVM)
%           timeBins:       desired time points
% Outputs   output:         discrimination cell matrix with ap,d and c.
if nargin<2
    idNum=size(DataMat,2)/2;
    numOfperm=1000;
    cPar=1;
    timeBins=size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['number of permutations: ' num2str(numOfperm)]);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(timeBins)]);
elseif nargin<3
    numOfperm=1000;
    cPar=1;
    timeBins=size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['number of permutations: ' num2str(numOfperm)]);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(timeBins)]);
elseif nargin<4
    cPar=1;
    timeBins=size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['number of permutations: ' num2str(numOfperm)]);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(timeBins)]);
elseif nargin<5
    timeBins=size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['number of permutations: ' num2str(numOfperm)]);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(timeBins)]);
end
rng('shuffle') 
DataMat=DataMat(:,:,:,timeBins);
combos = nchoosek([1:idNum],2); % setting number of combinations of identities
permMat=zeros(size(DataMat,3)*2,numOfperm);
ranMat=rand(size(DataMat,3)*2,numOfperm)-0.5;
permMat(ranMat>0)=1;
tic
for in=1:size(DataMat,4);
    for emo=1:2;
        for j=1:size(combos,1)
            parfor i=1:numOfperm
                [ap, d, c]=apply_classf_libsvm_MA_full_DN_perm(squeeze(DataMat(:,:,:,in)),combos(j,:),emo,permMat(:,i)); %FOR TRUE CLASSIFICATION
                apOut_par(i, 1)=ap;
                dOut_par(i, 1)=d;
                cOut_par(i, 1)=c;
            end
            apOut(emo,j,:)=apOut_par;
            dOut(emo,j,:)=dOut_par;
            cOut(emo,j,:)=cOut_par;
        end
    end
    output.ap(in,:,:,:)=apOut;
    output.d(in,:,:,:)=dOut;
    output.c(in,:,:,:)=cOut;
    in
    toc
end
disp('End of process')
toc

