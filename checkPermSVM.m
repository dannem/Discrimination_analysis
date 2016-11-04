function [perc,matOut]=checkPermSVM(output_disc,inds)
%% this function ouptuts the percentile of the true SVM from permutations.
% input : structure produced by runSVM
%       : indexes to choose pairs (e.g. for unfamiliar faces)
if nargin==2
    output_disc.perm.ap=output_disc.perm.ap(:,:,inds,:);
    output_disc.ap=output_disc.ap(:,:,inds);
end
for i=1:size(output_disc.ap,1);
    value=squeeze(mean(mean(output_disc.ap(i,:,:),2),3));
    mat=squeeze(mean(mean(output_disc.perm.ap(i,:,:,:),2),3));
    matOut(i,:)=mat;
    perc(i)=sum(mat>=value)/length(mat);
end