function output = runSVM_DN(DataMat,idNum,cPar)
if nargin<3
    cPar=1;
end
combos = nchoosek([1:idNum],2); % setting number of combinations of identities
tic
h = waitbar(0,'Please wait...');

for emo=1:2;
    for j=1:size(combos,1)
        waitbar((j+(emo-1)*length(combos)) / (size(combos,1)*2))
        parfor i=1:size(DataMat,4)
            [ap, d, c]=apply_classf_libsvm_MA_full_DN(squeeze(DataMat(:,:,:,i)),combos(j,:),emo,cPar); %FOR TRUE CLASSIFICATION
            apt(i,:)=ap;
            dt(i,:)=d;
            ct(i,:)=c;
        end
        outAcc.ap(emo,j,:,:)=apt;
        outAcc.d(emo,j,:,:)=dt;
        outAcc.c(emo,j,:,:)=ct;
    end
end
output=outAcc;
toc
close(h)
