clear apOut
clear dOut
clear perRes
clear dprRes
clear ans


perm=0; % SET 1 IF PERMUTATIONS, 0 IF TRUE DISCRIMINATION


maindir='/Users/VisRecLab/Documents/Reconstruction/SVM';
% files=dir([maindir '/*GEI.mat']);
cd(maindir);
result=[];
if perm
    numOfperm=10000;
else
    numOfperm=1;
end

combos = nchoosek([1:59],2); % setting number of combinations of identities
h = waitbar(0,'Please wait...');
%apOut=NaN(size(DataMat,4), 6,
for k=1:length(files)
    load([maindir '/' files(k).name]);
    dataIn='DataMat=data.mat;'
    eval(dataIn)
    
    for in=1:numOfperm
        waitbar((numOfperm*(k-1)+in) / (numOfperm*length(files)))
        for emo=1:2;
            
            for j=1:size(combos,1)
                if perm
                    parfor i=1:size(DataMat,4)
                        
                        [ap, d, c]=apply_classf_libsvm_MA_full_DN_perm(squeeze(DataMat(:,:,:,i)),combos(j,:),emo); %FOR PERMUTATIONS
                        apOut_par(i, 1)=ap;
                        dOut_par(i, 1)=d;
                        cOut_par(i, 1)=c;
                        
                    end
                else
                    for i=1:size(DataMat,4)
                        [ap, d, c]=apply_classf_libsvm_MA_full_DN(squeeze(DataMat(:,:,:,i)),combos(j,:),emo); %FOR TRUE CLASSIFICATION
                        apOut_par(i, 1)=ap;
                        dOut_par(i, 1)=d;
                        cOut_par(i, 1)=c;
                        
                    end
                end
                apOut(:,j, emo)=apOut_par;
                dOut(:,j, emo)=dOut_par;
                cOut(:,j, emo)=cOut_par;
                
            end
            
            
        end
        
        
        
        prcRes(in,:,:,:)=apOut;
        dprRes(in,:,:,:)=dOut;
        cRes(in,:,:,:)=cOut;
        
    end
    
    if perm
        data(1).perm_prcRes=prcRes;
        data(1).perm_dprRes=dprRes;
        data(1).perm_cRes=cRes;
    else
        
        eval(['data(1).true_' dataIn(1,14:end-1) '_prcRes=squeeze(prcRes)']);
        eval(['data(1).true_' dataIn(1,14:end-1) '_dprRes=squeeze(dprRes)']);
        eval(['data(1).true_' dataIn(1,14:end-1) '_cRes=squeeze(cRes)']);
%         data(1).true_dprRes=squeeze(dprRes);
%         data(1).true_cRes=squeeze(cRes);
    end
    try
        
        save([data.name '_' datestr(now, 'dd-mmm-yyyy')  '_GEI.mat'],'data')
        
    end
    
end
close(h)

