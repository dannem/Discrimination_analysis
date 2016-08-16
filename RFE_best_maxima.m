%% best discrimination by time points.
results=[];
for i=1:199
    ind=200-i;
    output=RFE_find_maxima_in_bins(output_disc_03,output_same_uw_03,100,ind);
    [output,~]=runSVM(output,60);
    results=[results; ind,squeeze(mean(output.ap(:,1,:),3))];
    save('/Users/dannem/Desktop/results.mat','results');
end