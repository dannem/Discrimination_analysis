%% average of discrimination
clear true_all all;
maindir='/Users/dannemrodov/Documents/GEI/GEI_analysis/SVM/Occipital';
files=dir([maindir '/*GEI.mat']);
cd(maindir);


for k=1:length(files)
    load([maindir '/' files(k).name]);
%     true_data=squeeze(data.true_dprRes);
    true_data=squeeze(data.true_mat_dprRes);
    true_all(k,:)=mean(mean(true_data,3),2)';
    true_within(k,:)=mean(mean(true_data(:,[1 6],:),3),2)';
    true_between(k,:)=mean(mean(true_data(:,[2:5],:),3),2)';
end
%fixing first two
% true_all(1:2,1:410-15)=true_all(1:2,16:410);
% true_between(1:2,1:410-15)=true_between(1:2,16:410);
% true_within(1:2,1:410-15)=true_within(1:2,16:410);
bins=size(data.mat,4);
until=data.uplim;

% prepare standard error
all(1,:)=mean(true_all,1)+std(true_all)/sqrt(length(files));
all(2,:)=mean(true_all,1)-std(true_all)/sqrt(length(files));

between(1,:)=mean(true_between,1)+std(true_all)/sqrt(length(files));
between(2,:)=mean(true_between,1)-std(true_all)/sqrt(length(files));

within(1,:)=mean(true_within,1)+std(true_all)/sqrt(length(files));
within(2,:)=mean(true_within,1)-std(true_all)/sqrt(length(files));

clearvars -except true_all true_between true_within all between within until bins

%plotting
figure
plot(linspace(-100,until,bins),mean(true_all,1),'r')
hold on
plot(linspace(-100,until,bins),mean(true_between,1),'g')
hold on
plot(linspace(-100,until,bins),mean(true_within,1),'b')
hold on
legend('all','between','within')

plotshaded(linspace(-100,until,bins),all,'r')
hold on
plotshaded(linspace(-100,until,bins),between,'g')
hold on
plotshaded(linspace(-100,until,bins),within,'b')
hold off
xlabel('time')
ylabel('D prime')
title('Grand average of discrimination all_el')

%% average of correlations
maindir='/Users/dannemrodov/Documents/GEI/GEI_analysis/SVM';
files=dir([maindir '/*GEI.mat']);
cd(maindir);

for k=1:length(files)
    load([maindir '/' files(k).name]);
    true_data=squeeze(data.true_mat_dprRes);
    for j=1:size(data.true_mat_dprRes,1)
    corrVec(j)=corr(mean(data.dist.PCA,1)',mean(true_data(j,:,:),3)');
    end
    
    true_all(k,:)=corrVec;
end
%fixing first two
% true_all(1:2,1:410-15)=true_all(1:2,16:410);
bins=size(data.mat,4);
until=data.uplim;

% all(2,:)=mean(true_all,1);
all(1,:)=mean(true_all,1)+std(true_all)/sqrt(length(files));
all(2,:)=mean(true_all,1)-std(true_all)/sqrt(length(files));

clearvars -except true_all all bins until

%plotting
figure
plot(linspace(-100,until,bins),mean(true_all,1),'r')
hold on
legend('all')
plotshaded(linspace(-100,until,bins),all,'r')
hold off
xlabel('time')
ylabel('D prime')
title('Grand average of correlation')

