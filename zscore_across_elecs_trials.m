function output=zscore_across_elecs_trials(cellIn)
output=cell(size(cellIn));
elc_num=size(cellIn{1,1},2);
tim_bin=size(cellIn{1,1},3);
id_num=size(cellIn,1);
bck_num=size(cellIn,2);
for i=1:bck_num %going through blocks
    for j=1:tim_bin % going through time
        bk_temp=[];
        for k=1:id_num % going through identities
            if isempty(cellIn{k,i})% if there is no trials for the cell do nothing
            else
            temp=cellIn{k,i}; % take the cell
            temp=temp(:,:,j); % take the time point
            ids=size(temp,1); % how many trials is in the cell
            els=size(temp,2);
            temp=temp(:); % vectorize all the trials
            temp=zscore(temp); % compute zscore over trials and elecs
            temp=reshape(temp,ids,els); % reconstructin matrix
            output{k,i}(:,:,j)=temp;
            end
        end
        
    end
end
        