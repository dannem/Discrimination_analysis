function [ttest_vec,crit]=disc_ttest(accIn,stimNum,qvalue,tm_start,tm_end)
%% This function takes discrimination cell output and perfroms a series of ttests
% for each time point comparing sample of averaged discrimination of every
% face (all possible pairs) against 0.
% Input:    accIn:      output of SVM analysis. Provide matrix with the
%                       desired index (e.g. acc.ap);
%           stimNum:    number of identities.
%           qvalue:     for fdr correction
%           tm_start:   for plotting: beggining of the epoch
%           tm_end:     for plotting: end of the epoch
% Output:   ttest_vec:  vector with p-values of the time axis length.
%           crit:       FDR-corrected threshold;
% Written by DN for VisRecLab.

%% Routine
combos = nchoosek([1:stimNum],2);
ttest_vec=NaN(1,size(accIn,3));
if size(combos,1)~=size(accIn,2)
    error('The number of identities is not consistent with the size of the discrimination matrix');
end
for i=1:size(accIn,3)
    temp=NaN(stimNum,stimNum);
    for j=1:size(combos,1)
        temp(combos(j,1),combos(j,2))=mean(accIn(:,j,i),1);
        temp(combos(j,2),combos(j,1))=mean(accIn(:,j,i),1);
    end
    temp=nanmean(temp,2);
    [~,ttest_vec(i)]=ttest(temp,0,'Tail','both');
end
 crit=FDR_comp_DN(ttest_vec(i),qvalue);
 if isempty(crit)
     display('No FDR correction criterion was obtained')
 elseif nargin>4
     figure
     semilogy(linspace(tm_start,tm_end,size(accIn,3)),ttest_vec)
     hold on
     semilogy(linspace(tm_start,tm_end,size(accIn,3)),ones(1,size(accIn,3))*crit)
     title('Two-tailed ttest against zero results')
     legend('Discrimination p-values','FDR-corrected criterion')
     axis([tm_start tm_end 0 1])
 end
     
    
    
