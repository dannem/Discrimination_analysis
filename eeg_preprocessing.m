%% Input: an images X blocks cell matrix produced by aggrERP.m

%% eeg preporcessing script
% load('/Users/dannem/Documents/Reconstruction/Analysis/s10_data_cleaned_eeg.mat');
%% importing data from lwdata
[output,ind]=lwdata2cell(lwdata,'id','bl','seg','but');
% output(61:100,:)=[];
output=output(:,[2:17 19:end]); %removing training
clear ind
%% zscoring 
% output=zscore_across_elecs_trials_ids(output_03); %across trials and
% electrodes and images`
% output=zscore_across_elecs_time(output); % across electrodes and time
output=zscore_iden_and_iter(output,3); % zscore + thresholding across trials: ids X emotions X repetitions
%% normalizing the data (between 0 and 1) and removing outliers (>3 std).
% output=norm_oulier_cap(output);
%% arranging identities in pairs
output=arrange_inds(output);
%% averging trials
% output_all=average_eeg(output,1);
% output_same_w=average_eeg(output,2);
% output_diff_w=average_eeg(output,3);
output_same_uw=average_eeg(output,4);
% output_diff_uw=average_eeg(output,5);
% output_same_w_3=average_eeg(output,6);
clear output

%% average=0
% output_same_uw=norm_oulier_cap(output_same_uw);

%% saving
save('/Users/dannem/Desktop/ERP_s03.mat','output_same_uw');