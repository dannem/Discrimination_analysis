%% only familiar
% out=perm_separation(60,54);
% output_disc_14.ap=output_disc_14.ap(:,:,out.indOne);
% output_disc_13.ap=output_disc_13.ap(:,:,out.indOne);
% output_disc_12.ap=output_disc_12.ap(:,:,out.indOne);
% output_disc_11.ap=output_disc_11.ap(:,:,out.indOne);
% output_disc_10.ap=output_disc_10.ap(:,:,out.indOne);
% output_disc_07.ap=output_disc_07.ap(:,:,out.indOne);
% output_disc_05.ap=output_disc_05.ap(:,:,out.indOne);
% output_disc_03.ap=output_disc_03.ap(:,:,out.indOne);
% output_disc_07.ap=output_disc_07.ap(:,:,out.indOne);
%% plot
all=plotMultipleDiscriminations(-100,900,1,1,...
    output_disc_03, output_disc_05, output_disc_07, output_disc_10, output_disc_11, output_disc_12, output_disc_13, output_disc_14);
% output_disc_03,output_disc_05,output_disc_07

%% average plot
figure
plot(linspace(-100,900,size(all,2)),mean(all,1));
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