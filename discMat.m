function x=discMat(strct,numLow,numHigh)
out=perm_separation(60,54);
if nargin<2
    numHigh=size(strct,2);
    numLow=1;
elseif nargin<3
    numHigh=size(strct,2);
end
x=[];
for i=numLow:numHigh
  temp=squeeze(mean(mean(strct(i).ap(:,:,out.indOne),3),2));
  x=[x temp];
end
    