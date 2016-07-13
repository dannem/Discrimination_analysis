%% only familiar
out=perm_separation(60,54);
output_disc_03_unf_el.ap=output_disc_03_el.ap(:,:,out.indOne);
output_disc_05_unf_el.ap=output_disc_05_el.ap(:,:,out.indOne);
output_disc_07_unf_el.ap=output_disc_07_el.ap(:,:,out.indOne);
output_disc_03_unf_old.ap=output_disc_03_old.ap(:,:,out.indOne);
output_disc_05_unf_old.ap=output_disc_05_old.ap(:,:,out.indOne);
output_disc_07_unf_old.ap=output_disc_07_old.ap(:,:,out.indOne);
%% plot
plotMultipleDiscriminations(-100,900,1,1,...
    output_disc_03_unf_el,output_disc_05_unf_el,output_disc_07_unf_el,...
    output_disc_03_unf_old,output_disc_05_unf_old,output_disc_07_unf_old)
% output_disc_03,output_disc_05,output_disc_07
%% time X emotions X pairs
%Arguments:
% 1.    start of the epoch
% 2.    end of the epoch
% 3.    number of bins: 1 - based on data; else - length
% 4.    kind of variable: 1 - accuracy; 2 - d prime; 3 - c
% 5.    all the 'acc' files
%Example: plotMultipleDiscriminations(-100,900,1,1,output1,output2)
%Example: plotMultipleDiscriminations(-100,900,500,1,output1,output2)

%% Archive
% plotMultipleDiscriminations(-100,900,500,1,output_disc_20_1, ...
%     output_disc_20_2, output_disc_20_3, output_disc_20_4, output_disc_20_5,...
%     output_disc_20_6, output_disc_20_7, output_disc_20_8, output_disc_20_9,...
%     output_disc_20_10)