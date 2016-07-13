%% plotBlocksImage
matOut=output_same_uw_03;
timeBin=134;
im1=1;
im2=3;
im3=5;
figure
subplot(3,2,1)
imagesc(squeeze(matOut(:,im1,:,timeBin)));
colorbar
subplot(3,2,2)
imagesc(squeeze(matOut(:,im2,:,timeBin)));
colorbar
subplot(3,2,3)
imagesc(squeeze(matOut(:,im3,:,timeBin)));
colorbar
subplot(3,2,4)
imagesc(squeeze(matOut(:,im1+1,:,timeBin)));
colorbar
subplot(3,2,5)
imagesc(squeeze(matOut(:,im2+1,:,timeBin)));
colorbar
subplot(3,2,6)
imagesc(squeeze(matOut(:,im3+3,:,timeBin)));
colorbar
clear timeBin matOut im1 im2 im3