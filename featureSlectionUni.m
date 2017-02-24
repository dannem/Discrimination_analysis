function [output]=featureSlectionUni(data,reps,groupA,groupB)
matHapA=data(:,groupA);
matNeutA=data(:,groupA+size(data,2)/2);
matHapB=data(:,groupB);
matNeutB=data(:,groupB+size(data,2)/2);
        
for i=1:reps
    inds=groupA(randperm(max(groupA)));
    inds=inds(1:length(groupB));
    temp=matHapA(:,inds);
    [a,b,c,stats]=ttest(temp',matHapB');
    output.happ(i,:)=stats.tstat;
    temp=matNeutA(:,inds);
    [a,b,c,stats]=ttest(temp',matNeutB');
    output.neut(i,:)=stats.tstat;
    temp=[matHapA(:,inds) matNeutA(:,inds)];
    [a,b,c,stats]=ttest(temp',[matHapB matNeutB]');
    output.all(i,:)=stats.tstat;
    output.inds=inds;
end
    
    
        

