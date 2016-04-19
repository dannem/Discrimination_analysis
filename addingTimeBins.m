function outputOut=addingTimeBins(outputIn,times)
temp=outputIn;
if times>1
    for i=1:times
        addMat=outputIn(:,:,:,i+1:end);
        temp=temp(:,:,:,1:end-1);
        temp=cat(1,temp,addMat);
        
    end
end
outputOut=temp;