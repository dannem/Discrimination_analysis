function output=average_eeg(inCell,type)
%% inputs: 
% inCell    cell with images X block structure (ouput of aggrERP)
% type      1 - per block; 2 - in pairs weighted within session; 3 - in pairs weighted across
%           session; 4 - in pairs unweighted within session; 5 - in pairs
%           unweighetd  across session;
% written by DN & Ash.
%% routine
if nargin<2 % default averiging within session
    type=1;
end

if type==1
    output=NaN(size(inCell,1),size(inCell,2),size(inCell{1,1},2),...
        size(inCell{1,1},3));
    for i=1:size(inCell,1)
        for j=1:size(inCell,2)
            temp=inCell{i,j};
            temp=mean(temp,1);
            output(i,j,:,:)=temp;
        end
    end
elseif type==2 %within session - weighted
    output=NaN(size(inCell,1),size(inCell,2)/2,size(inCell{1,1},2),...
        size(inCell{1,1},3));
    for i=1:size(inCell,1)% going through images
        for j=1:size(inCell,2)/2% going through blocks
            temp1=inCell{i,j*2-1};
            temp2=inCell{i,j*2};
            temp=cat(1,temp1,temp2);
            temp=mean(temp,1);
            output(i,j,:,:)=temp;
        end
    end
elseif type==3 % between sessions - weighted
    output=NaN(size(inCell,1),size(inCell,2)/2,size(inCell{1,1},2),...
        size(inCell{1,1},3));
    blk_num=size(inCell,2)/2;
    for i=1:size(inCell,1)
        for j=1:size(inCell,2)/2
            temp1=inCell{i,j};
            temp2=inCell{i,j+blk_num};
            temp=cat(1,temp1,temp2);
            temp=mean(temp,1);
            output(i,j,:,:)=temp;
        end
    end
elseif type==4 %within session %unweighted averages
    output=NaN(size(inCell,1),size(inCell,2)/2,size(inCell{1,1},2),...
        size(inCell{1,1},3));
    for i=1:size(inCell,1)% going through images
        for j=1:size(inCell,2)/2% going through blocks
            temp1=inCell{i,j*2-1};
            temp1=mean(temp1,1);
            temp2=inCell{i,j*2};
            temp2=mean(temp2,1);
            temp3=cat(1,temp1,temp2);
            temp=mean(temp3,1);
            output(i,j,:,:)=temp;
        end
    end
else %unweighted averages % between session 
    output=NaN(size(inCell,1),size(inCell,2)/2,size(inCell{1,1},2),...
        size(inCell{1,1},3));
    blk_num=size(inCell,2)/2;
    for i=1:size(inCell,1)
        for j=1:size(inCell,2)/2
            temp1=inCell{i,j};
            temp1=mean(temp1,1);
            temp2=inCell{i,j+blk_num};
            temp2=mean(temp2,1);
            temp3=cat(1,temp1,temp2);
            temp=mean(temp3,1);
            output(i,j,:,:)=temp;
        end
    end
end
output=permute(output,[3,1,2,4]);   