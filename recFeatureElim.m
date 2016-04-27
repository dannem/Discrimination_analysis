function output=recFeatureElim(matIn);
% RFE funciton
matIn=output_diff_w; % size matrix in: els X ids X blocks X time
els=size(matIn,1);
blocks=size(matIn,3);
bins=size(matIn,4);
ids=size(matIn,2)/2;

%% choosing pairs for each stage
numPerStage=ids/3;
numStage1=ceil(numPerStage)
numStage2=ceil(numPerStage)
numStage3=ids-numStage1-numStage2
indx=[ones(1,numStage1)*1 ones(1,numStage2)*2 ones(1,numStage3)*3]';
indx=indx(randperm(ids));
indVec=NaN(ids*2,1);
indVec(1:2:end)=indx;
indVec(2:2:end)=indx;

%% functions
function 