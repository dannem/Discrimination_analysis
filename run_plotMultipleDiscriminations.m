plotMultipleDiscriminations(-100,900,500,1,output_disc_20_1, output_disc_10_blocks, output_disc_16_blocks)

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