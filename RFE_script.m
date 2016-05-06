% RFE process
%% finding maxima time points based on SVM performed on all ics.
% beginning: 50 ms post stimulus
% size: 40 ms.
% number of bins: 20
output.s50_b40_n20=RFE_find_maxima_in_bins(output_disc,output_same_uw,50,40,20);
output.s100_b40_n19=RFE_find_maxima_in_bins(output_disc,output_same_uw,100,40,19);
output.s150_b40_n18=RFE_find_maxima_in_bins(output_disc,output_same_uw,150,40,18);
output.s50_b80_n10=RFE_find_maxima_in_bins(output_disc,output_same_uw,50,80,10);
output.s50_b30_n26=RFE_find_maxima_in_bins(output_disc,output_same_uw,50,30,26);
output.s50_b20_n35=RFE_find_maxima_in_bins(output_disc,output_same_uw,50,20,35);
output.s50_b20_n30=RFE_find_maxima_in_bins(output_disc,output_same_uw,50,20,30);
%% performing ranking
output_rank.s50_b40_n20=RFE_SVM_ICA(output.s50_b40_n20,59,68);
output_rank.s100_b40_n20=RFE_SVM_ICA(output.s100_b40_n20,59,68);
output_rank.s150_b40_n20=RFE_SVM_ICA(output.s150_b40_n20,59,68);
output_rank.s50_b80_n10=RFE_SVM_ICA(output.s50_b80_n10,59,68);
output_rank.s50_b30_n26=RFE_SVM_ICA(output.s50_b30_n26,59,68);
output_rank.s50_b20_n35=RFE_SVM_ICA(output.s50_b20_n35,59,68);
output_rank.s50_b20_n30=RFE_SVM_ICA(output.s50_b20_n30,59,68);


%% visualizing orders
output_rank_mean=mean(mean(output_rank.s50_b20_n30,2),3);
output_rank_mean=output_rank_mean(1:68);
[b,rank_ics]=sort(output_rank_mean);

%% performing discrimination
[output,feat_num] =RFE_discr_cumul(output.s50_b40_n20,output_rank.s50_b40_n20,20,59);


%% plottig discrimination
s50_b40_n20(:,1)=mean(mean(svm.s50_b40_n20.ap1,2),3);
s50_b40_n20(:,2)=mean(mean(svm.s50_b40_n20.ap2,2),3);
s50_b40_n20=mean(s50_b40_n20,2);

s100_b40_n19(:,1)=mean(mean(svm.s100_b40_n19.ap1,2),3);
s100_b40_n19(:,2)=mean(mean(svm.s100_b40_n19.ap2,2),3);
s100_b40_n19=mean(s100_b40_n19,2);

s150_b40_n18(:,1)=mean(mean(svm.s150_b40_n18.ap1,2),3);
s150_b40_n18(:,2)=mean(mean(svm.s150_b40_n18.ap2,2),3);
s150_b40_n18=mean(s150_b40_n18,2);

s50_b20_n35(:,1)=mean(mean(svm.s50_b20_n35.ap1,2),3);
s50_b20_n35(:,2)=mean(mean(svm.s50_b20_n35.ap2,2),3);
s50_b20_n35=mean(s50_b20_n35,2);

figure
plot(s50_b40_n20)
hold on
plot(s100_b40_n19)
hold on
plot(s150_b40_n18)
hold on
plot(s50_b20_n35)
title('Graph of Sine and Cosine Between -2\pi and 2\pi')
legend('start: 50 ms; length: 40 ms; size: 20 bins',...
    'start: 100 ms; length: 40 ms; size: 19 bins',...
    'start: 150 ms; length: 40 ms; size: 18 bins',...
    'start: 50 ms; length: 20 ms; size: 35 bins')
xlabel('ICs')
ylabel('accuracy %')