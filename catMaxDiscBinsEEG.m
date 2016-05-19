
disc=squeeze(mean(mean(output_disc_10_blocks_zscore2.ap,2),3));
%removing 119 seconds (19 post stimulus)
remBin=62;
% removing  170 seconds (70 post stimulus)
% remBin=87;
% removing 180 seconds (80 post stimulus)
% remBin=92;
disc(1:remBin)=[];

%creating index of maxima
binSize=25;
indexMax=[];
disc1=reshape(disc,binSize,18);
maxdisc=max(disc1);
for i=1:size(disc1,2)
    a=find(disc1(:,i)==maxdisc(i));
    indexMax(i)=remBin+size(disc1,1)*i+a-size(disc1,1);
end

% load data 64 X 118 X  16 X 512
output_same_w_3=output_same_w_3(:,:,:,indexMax); 
out=[];
for i=1:size(indexMax,2)
    out=cat(1,out,output_same_w_3(:,:,:,i));
end
output_same_w_3=out;
clear a binSize disc disc1 i indexMax maxdisc out remBin

%%
a=squeeze(mean(mean(output_disc3.ap,2),3));

%% Comments
% SVM on icfilted data
% Based on data with icfilt_02. In: 1,3:10,21:68 max discrimination bins were computed as maximum discrimination during the period using CatMaxBinsDiscEEG.m and SVM_script.m as following
% 
% - for each 25 bins (50 ms) starting with 19 ms post stimulus. Ouptut: acc25bins_from19
% - for each 25 bins (50 ms) starting with 70 ms post stimulus. Ouptut: acc25bins_from70
% - for each 15 bins (30 ms) starting with 80 ms post stimulus. Ouptut: acc15bins_from80
% 
% The summary of all three approaches and all outputs from 1 were saved as SVM_s20_concatenated_max_bins_mat
% The best result (0.5511) was found in acc25bins_from19
% It was decided to run reconstruction based on results from 8 combined bins (419ms post stimulus) and 16 combined bins (819 ms).