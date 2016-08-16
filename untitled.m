%% best discrimination by time points.
results=[];
for i=200:197
    output=RFE_find_maxima_in_bins(output_disc_03,output_same_uw_03,100,i);
    [output,~]=runSVM(output,60);
    results=[results; i,squeeze(mean(output.ap(:,1,:),3))];
end