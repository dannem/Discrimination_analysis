function plotMultipleDiscriminations(begTime,endTime,kind,varargin)
%% Arguments:
% 1.    start of the epoch
% 2.    end of the epoch
% 3.    kind of variable: 1 - accuracy; 2 - d prime; 3 - c
% 4.    all the 'acc' files
%%
x=linspace(begTime,endTime,size(varargin{1}.ap,3));
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
    temp=squeeze(mean(mean(temp,2),1));
    plot(x,temp)
    hold on
    legNames{counter}=inputname(3+i);
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
