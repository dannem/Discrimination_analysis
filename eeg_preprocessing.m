%% Input: an images X blocks cell matrix produced by aggrERP.m

%% eeg preporcessing script
load('Users/dannem/Documents/Reconstruction/Analysis/s10_data_cleaned_eeg.mat');
%% zscoring across trials and electrodes
output=zscore_across_elecs_trials(s10_eeg_data);
%% arranging identities in pairs
output=arrange_inds(output);
%% averging trials
output_all=average_eeg(output,1);
output_same_w=average_eeg(output,2);
output_diff_w=average_eeg(output,3);
output_same_uw=average_eeg(output,4);
output_diff_uw=average_eeg(output,5);