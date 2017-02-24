for i=1:64
    i
    for j=1:512
        temp=squeeze(output(i).data.output_same_uw(i,:,:,j));
        [a,b]=anova_rm(temp','off');
        result(i,j)=b{2,5};
        close all
    end
end
x=linspace(-100,900,512); 
y=1:64; 
imagesc(x,y,result);
