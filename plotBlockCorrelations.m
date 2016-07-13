%%
matOut=output_same_uw_03;
im=[1 2 3 4 5 6];
figure
for j=im
    k=j+6*12;
    for i=1:size(matOut,4)
        a=squeeze(matOut(:,k,:,i));
        R = corrcoef(a);
        R1 = corrcoef(a');
        aa=mean(R);
        aa1=mean(R1);
        out(i,:)=aa;
        out1(i,:)=aa1;
    end
    aveCorr=mean(out');
    elecCorr(j,:)=mean(out1);
    
    subplot(3,2,j)
    plot(linspace(-100,900,512),aveCorr)
end

% figure
% imagesc(out1);
% colorbar