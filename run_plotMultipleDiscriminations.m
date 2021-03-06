%% only familiar
out=perm_separation(60,54);
across_norm.ap=results.across_norm.ap(:,:,out.indOne);
within_norm.ap=results.within_norm.ap(:,:,out.indOne);
within_scale.ap=results.within_scale.ap(:,:,out.indOne);
across_scale.ap=results.across_scale.ap(:,:,out.indOne);
across_paper.ap=results.across_paper.ap(:,:,out.indOne);
within_paper.ap=results.within_paper.ap(:,:,out.indOne);
within_scale_all.ap=results.within_scale_all.ap(:,:,out.indOne);
across_scale_all.ap=results.across_scale_all.ap(:,:,out.indOne);
% across_64_els_5bins.ap=output_disc_acorss_64el_5bins.ap(:,:,out.indOne);
% across_64_els_1bin.ap=output_disc_acorss_64el_1bin.ap(:,:,out.indOne);
% within_4_els_5bins.ap=output_disc_within_4els_5bins.ap(:,:,out.indOne);
% within_64_els_5bins.ap=output_disc_within_64els_5bins.ap(:,:,out.indOne);
% elec22.ap=output_by_elec(22).ap(:,:,out.indOne);
% elec3.ap=output_by_elec(3).ap(:,:,out.indOne);
% elec4.ap=output_by_elec(4).ap(:,:,out.indOne);
% elec5.ap=output_by_elec(5).ap(:,:,out.indOne);
% elec6.ap=output_by_elec(6).ap(:,:,out.indOne);
% elec7.ap=output_by_elec(7).ap(:,:,out.indOne);
% elec8.ap=output_by_elec(8).ap(:,:,out.indOne);
% elec9.ap=output_by_elec(9).ap(:,:,out.indOne);
% elec10.ap=output_by_elec(10).ap(:,:,out.indOne);
% elec11.ap=output_by_elec(11).ap(:,:,out.indOne);
% elec12.ap=output_by_elec(12).ap(:,:,out.indOne);
% elec13.ap=output_by_elec(13).ap(:,:,out.indOne);
% elec14.ap=output_by_elec(14).ap(:,:,out.indOne);
% elec15.ap=output_by_elec(15).ap(:,:,out.indOne);
% elec16.ap=output_by_elec(16).ap(:,:,out.indOne);
% elec17.ap=output_by_elec(17).ap(:,:,out.indOne);
% elec18.ap=output_by_elec(18).ap(:,:,out.indOne);
% elec64.ap=output_by_elec(64).ap(:,:,out.indOne);
% % output_disc_12dc.ap=output_disc_12dc.ap(:,:,out.indOne);
% % output_disc_11dc.ap=output_disc_11dc.ap(:,:,out.indOne);
% % output_disc_10dc.ap=output_disc_10dc.ap(:,:,out.indOne);
% % output_disc_07dc.ap=output_disc_07dc.ap(:,:,out.indOne);
% % output_disc_05dc.ap=output_disc_05dc.ap(:,:,out.indOne);
% output_disc_03dc.ap=output_disc_03dc.ap(:,:,out.indOne);
% output_disc_13dc.ap=output_disc_13dc.ap(:,:,out.indOne);
%% plot

plotMultipleDiscriminations(-100,900,1,1,...
  across_norm, across_scale,across_paper,across_scale_all);
plotMultipleDiscriminations(-100,900,1,1,...
 within_norm, within_scale,within_paper,within_scale_all);
%%
figure
subplot(2,1,1)
plot(perc)
subplot(2,1,2)
plot(mean(mean(output_disc_across.ap,2),3))
%%
all_d=plotMultipleDiscriminations(-100,900,1,1,...
   sub_all_09_across, sub_all_10_within, sub_all_12_across, sub_all_12_within);
%     elec1,elec2,elec3,elec4,elec5,elec6,elec7,elec8,elec9,elec10);
% output_disc_03,output_disc_05,output_disc_07

%% boxplot
% load('/Users/dannem/Desktop/SVM_all_by_elec_26-Aug-2016.mat')
x=discMat(output_by_elec,1,1);
figure
boxplot(x,'Whisker',0);

%% average plot
% figure
% plot(linspace(-100,900,size(all,2)),mean(all,1));
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