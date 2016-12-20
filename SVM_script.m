%% run SVM srciptv
% matrix in: el X im X bl X time
%% parameters
id_num=60;
output_folder='/Users/dannem/Documents/Reconstruction/Analysis/SVM/Results/';
mkdir(output_folder);
c=1;
perms=999;
% load('/Users/VisRecLab/Documents/Reconstruction/SVM/Data/s10_single_trial_discr.mat')
%% 6.03.2016
%permutations
try
    
%     filename=['SVM_s20_ica'];
    [output_disc3,perm_mat] = runSVM(output_same_uw,id_num,c,512);
%     save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output','perm_mat');
    toc
    
    % true
    
    disp('End job');
catch ME
    disp('Error occured')
    rethrow(ME)
end
% poolobj=gcp('nocreate');
% delete(poolobj);
% c= parcluster('default_jobmanager');
% finished_jobs=findJob(c,'State','finished','Username','nestorad');
% delete(finished_jobs);

%% Archive
% %% 3.03.2016
% filename='SVM_s10_perms'
% output = runSVM_DN(DataMat_same,id_num,c);
% save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
% toc
% figure
% temp=squeeze(mean(mean(output.ap,1),2));
% plot(linspace(-90,910,length(temp)),temp)
% title('s10_time_discr_same');
%
% filename='s10_diff'
% output = runSVM_DN(DataMat_diff,id_num,c);
% save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
% toc
% figure
% temp=squeeze(mean(mean(output.ap,1),2));
% plot(linspace(-90,910,length(temp)),temp)
% title('s10_time_discr_diff');

%% 1.03.2016

% for i=2:2:8
%     filename=['s10_time_discr_single_trials_all_cpower_' num2str(i)] ;
%     output = runSVM_DN(DataMat_all,id_num,2^i);
%     save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
%     toc
%     figure
%     temp=squeeze(mean(mean(output.ap,1),2));
%     plot(linspace(-90,910,length(temp)),temp)
%     title(filename);
% end
%% 26.02.2016
% %%
% filename='s10_time_discr_single_trials_all';
% output = runSVM_DN(DataMat_all,id_num,c);
% save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
% toc
% figure
% temp=squeeze(mean(mean(output.ap,1),2));
% plot(linspace(-90,910,length(temp)),temp)
% title('s10_time_discr_single_trials_all');
%
% filename='s10_time_discr_single_trials_sess1';
% output = runSVM_DN(DataMat_bk1,id_num,c);
% save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
% toc
% figure
% temp=squeeze(mean(mean(output.ap,1),2));
% plot(linspace(-90,910,length(temp)),temp)
% title('s10_time_discr_single_trials_session 1');
%
% filename='s10_time_discr_single_trials_sess2';
% output = runSVM_DN(DataMat_bk2,id_num,c);
% save([output_folder filename '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'output');
% toc
% figure
% temp=squeeze(mean(mean(output.ap,1),2));
% plot(linspace(-90,910,length(temp)),temp)
% title('s10_time_discr_single_trials_session 2');