function output=RFE_find_maxima_in_bins(disc,dataIn,startMS,binSizeMS,binNum,sRate)
disc=squeeze(mean(mean(disc.ap,2),3));
% convert times to bins
if nargin<6
    sRate=512;
end
    
binSize=round(binSizeMS/(1000/sRate));
startBin=round((startMS+100)/(1000/sRate));
if nargin<5
    binNum=floor((size(dataIn,4)-startBin)/binSize);
end
output=[];
for i=0:binNum-1
    indBeg=startBin+i*binSize; % beginning of the bin
    indLast=indBeg+binSize-1; % end of the bin
    tempd=disc(indBeg:indLast);
    [~,ind]=max(tempd);
    ind=ind+indBeg-1;
    output=cat(1,dataIn(:,:,:,ind),output);
end
    
    
    