function output = run_SVM_Alex(data,groupA,groupB,permNum)
tic
c=1;
optstr=['-s 0 -t 0 -c ', num2str(c), ' -q'];
train_lbl=repmat([zeros(5,1);ones(5,1)],2,1);
test_lbl=[0 1];
a=nchoosek(1:6,2);
possPairs=[a(:,1) a(:,2);a(:,2) a(:,1);1 1;2 2;3 3;4 4;5 5;6 6];
acc=NaN(2,size(possPairs,1));
ac=NaN(permNum,size(acc,1),size(acc,2));
% data=DataMat([22:27 59:64],:,:,78:78+306);
% data= permute(data,[4 1 2 3]);
% data=reshape(data,size(data,1)*size(data,2),120,16);
% data=normOneRange(data);
% data=mean(data,3);
dataFamHapp=data(:,groupB);
dataFamNeut=data(:,groupB+60);
dataUnfHapp=data(:,groupA);
dataUnfNuet=data(:,groupA+60);
unfInd=NaN(length(groupB),permNum);
for i=1:permNum
    temp=randperm(max(groupA));
    unfInd(:,i)=temp(1:length(groupB));
end
parfor i=1:permNum
    dataNeut=cat(2,dataFamNeut,dataUnfNuet(:,unfInd(:,i)));
    dataHapp=cat(2,dataFamHapp,dataUnfHapp(:,unfInd(:,i)));
    acc=[];
    for j=1:size(possPairs,1);
        train_V1=dataNeut;
        train_V1(:,[possPairs(j,1) possPairs(j,2)+length(groupB)])=[];
        train_V2=dataHapp;
        train_V2(:,[possPairs(j,1) possPairs(j,2)+length(groupB)])=[];
        train_V=[train_V1 train_V2];
        test_V=dataHapp(:,[possPairs(j,1) possPairs(j,2)+length(groupB)]);
        svmStruct = svmtrain(train_lbl, train_V', optstr);
        [lbl_clsf, ~, ~] = svmpredict(test_lbl', test_V', svmStruct,'-q');%optstr
        acc(1, j)=mean(single(lbl_clsf'==test_lbl));
        test_V=dataNeut(:,[possPairs(j,1) possPairs(j,2)+length(groupB)]);
        [lbl_clsf, ~, ~] = svmpredict(test_lbl', test_V', svmStruct,'-q');%optstr
        acc(2, j)=mean(single(lbl_clsf'==test_lbl));
%         H=H+sum(double((lbl_clsf'==1) & (test_lbl==1)));
%         FA=FA+sum(double((lbl_clsf==1) & (test_lbl==0)));
        
    end
    ac(i,:,:)=acc;
end
output.ac=ac;
output.mat=unfInd;
output.pair=possPairs;
toc

