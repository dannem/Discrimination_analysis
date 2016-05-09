%% Input: an images X blocks cell matrix produced by aggrERP.m

%% eeg preporcessing script
% load('/Users/dannem/Documents/Reconstruction/Analysis/s10_data_cleaned_eeg.mat');
%% importing data from lwdata
[output,ind]=lwdata2cell(lwdata,'idn','zsc','blc','icfilt');
% deleting empty cells 
output(60:100,:)=[]; 
ind(60:100,:)=[];
%% zscoring across trials and electrodes and identities
output=zscore_across_elecs_trials_ids(output);

%% normalizing the data (between 0 and 1) and removing outliers (>3 std).
output=norm_oulier_cap(output);
%% arranging identities in pairs
output=arrange_inds(output);
%% averging trials
% output_all=average_eeg(output,1);
% output_same_w=average_eeg(output,2);
% output_diff_w=average_eeg(output,3);
output_same_uw=average_eeg(output,4);
% output_diff_uw=average_eeg(output,5);