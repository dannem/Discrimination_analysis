function [output,permMat] = runSVM_same_emot(DataMat,idNum,cPar,timeBins,numOfperm)
%% This function computes SVM with permutations to assess significance.
% The input is a data file from eeg_preprocessing.m
% Inputs    DataMat:        4-D matrix (time: els X ims X bls X time)
%           idNum:          number of identities
%           numOfperm:      number of desired permutations. If none only
%                           true duscrimination,
%           cPar:           c (criterion value for SVM)
%           timeBins:       desired time points
% Outputs   output:         discrimination cell matrix with ap,d and c.
% Example for true discrimination only: 
%   [output,~] = runSVM(DataMat,59,1,[50 100])
% Example of permutation discrimination: 
%   [output,permMat] = runSVM(DataMat,59,1,[50 100],1000)

%% Checks
if nargin<2
    idNum=size(DataMat,2)/2;
    numOfperm=0;
    cPar=1;
    timeBins=1:size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['no permutations requested']);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(size(timeBins,2))]);
elseif nargin<3
    numOfperm=0;
    cPar=1;
    timeBins=1:size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['no permutations requested']);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(size(timeBins,2))]);
elseif nargin<4
    numOfperm=0;
    timeBins=1:size(DataMat,4);
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['no permutations requested']);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(size(timeBins,2))]);
elseif nargin<5
    numOfperm=0;
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['no permutations requested']);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(size(timeBins,2))]);
else
    disp(['number of idenities: ' num2str(idNum)]);
    disp(['number of permutations ' num2str(numOfperm)]);
    disp(['c-value for SVM: ' num2str(cPar)]);
    disp(['time points: ' num2str(size(timeBins,2))]);
end

%% Preparing arguments and outputs
permMat=[];
rng('shuffle')
DataMat=DataMat(:,:,:,timeBins);
combos = nchoosek([1:idNum],2); % setting number of combinations of identities
tic

%% computing true discrimination
% h = waitbar(0,'Please wait...');
for in=1:size(timeBins,2);
    apOut=NaN(length(combos),1);
    dOut=NaN(length(combos),1);
    cOut=NaN(length(combos),1);
    dataIn=squeeze(DataMat(:,:,:,in));
%     waitbar(in / size(timeBins,2))
    for emo=1:2;
        parfor j=1:size(combos,1)
            [ap, d, c]=apply_classf_libsvm_same_emot(dataIn,combos(j,:),emo,cPar);
            apOut(j)=ap;
            dOut(j)=d;
            cOut(j)=c;
        end
        output.ap(in,emo,:)=apOut;
        output.d(in,emo,:)=dOut;
        output.c(in,emo,:)=cOut;
    end
    in
    toc
end
% close(h)
toc
disp('End of true SVM');


%% computing permutations
if numOfperm
    disp('Start permutation test')
%     barOn=0; % if progress bar is needed
%     h = waitbar(0,'Please wait...');
    permMat=zeros(size(DataMat,3)*2,numOfperm);
    ranMat=rand(size(DataMat,3)*2,numOfperm)-0.5;
    permMat(ranMat>0)=1;
    tic
    for in=1:size(DataMat,4);
        apOut=NaN(2,length(combos),numOfperm);
        dOut=NaN(2,length(combos),numOfperm);
        cOut=NaN(2,length(combos),numOfperm);
        for emo=1:2;
            for j=1:size(combos,1)
%                 if barOn
%                     waitbar((j+(emo-1)*length(combos)) / (size(combos,1)*2))
%                 end
                com=combos(j,:);
                dataIn=squeeze(DataMat(:,:,:,in));
                apOut_par=NaN(numOfperm,1);
                dOut_par=NaN(numOfperm,1);
                cOut_par=NaN(numOfperm,1);
                parfor i=1:numOfperm
                    [ap, d, c]=apply_classf_libsvm_new_perm(dataIn,com,emo,permMat(:,i));
                    apOut_par(i)=ap;
                    dOut_par(i)=d;
                    cOut_par(i)=c;
                end
                apOut(emo,j,:)=apOut_par;
                dOut(emo,j,:)=dOut_par;
                cOut(emo,j,:)=cOut_par;
            end
        end
        output.perm.ap(in,:,:,:)=apOut;
        output.perm.d(in,:,:,:)=dOut;
        output.perm.c(in,:,:,:)=cOut;
        in
        toc
    end
%     close(h)
    disp('End of permutation analysis')
    toc
end



