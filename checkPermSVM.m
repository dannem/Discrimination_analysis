function [perc,matOut]=checkPermSVM(output_disc,emo,inds)
%% this function ouptuts the percentile of the true SVM from permutations.
% input : structure produced by runSVM
%       : indexes to choose pairs (e.g. for unfamiliar faces)
if nargin==3
    output_disc.perm.ap=output_disc.perm.ap(:,:,inds,:);
    output_disc.ap=output_disc.ap(:,:,inds);
elseif nargin==1
    emo=1;
end
if emo==1
for i=1:size(output_disc.ap,1);
    value=squeeze(mean(mean(output_disc.ap(i,:,:),2),3));
    mat=squeeze(mean(mean(output_disc.perm.ap(i,:,:,:),2),3));
    mat=[mat value];
    matOut(i,:)=mat;
    perc(i)=sum(mat>=value)/length(mat);
end
else
    for i=1:size(output_disc.ap,1);
    value=squeeze(mean(output_disc.ap(i,:,:),3))
    mat=squeeze(mean(output_disc.perm.ap(i,:,:,:),3));
    mat=[mat value'];
    matOut(i,:,:)=mat;
    perc(i,1)=sum(mat(1,:)>=value(1))/size(mat,2);
    perc(i,2)=sum(mat(2,:)>=value(2))/size(mat,2);
end
end