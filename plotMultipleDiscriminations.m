function [out]=plotMultipleDiscriminations(begTime,endTime,bins,kind,varargin)
% Function to present discrimination. Size: time X emotions X pairs
%% Arguments:
% 1.    start of the epoch
% 2.    end of the epoch
% 3.    number of bins: 1 - based on data; else - length
% 4.    kind of variable: 1 - accuracy; 2 - d prime; 3 - c
% 5.    all the 'acc' files
%%
if bins==1
    x=linspace(begTime,endTime,size(varargin{1}.ap,1));
else
    x=linspace(begTime,endTime,bins);
end
counter=1;
figure('units','normalized','outerposition',[0 0 1 1])
for i=1:length(varargin)
    temp=varargin{i};
    switch kind
        case 1
            temp=temp.ap;
        case 2
            temp=temp.d;
        case 3
            temp=temp.c;
    end
    if bins>1
        temp=temp(1:bins,:,:);
    end
    temp=squeeze(mean(mean(temp,2),3));
    out(counter,:)=temp;
    plot(x,temp)
    hold on
    legNames{counter}=inputname(4+i);
    try
    legNames{counter}=strrep(legNames{counter},'_m',' -');
    legNames{counter}=strrep(legNames{counter},'_p',' +');
    legNames{counter}=strrep(legNames{counter},'_',' ');
    catch
    end
    counter=counter+1;
    
end
legend(legNames,'Location','northwest')
xlim([begTime endTime])
