function output=zscore_across_elecs_trials_ids(cellIn)
output=cell(size(cellIn));
elc_num=size(cellIn{1,1},2);
tim_bin=size(cellIn{1,1},3);
id_num=size(cellIn,1);
bck_num=size(cellIn,2);
for i=1:bck_num %going through blocks
    for j=1:tim_bin % going through time
        bk_temp=[];
        for k=1:id_num % going through identities
            if isempty(cellIn{k,i})
            else
                temp=cellIn{k,i};
                temp=temp(:,:,j);
                id(k)=size(temp,1);
                temp=temp(:);
                bk_temp=[bk_temp;temp];
            end
        end
        bk_temp=zscore(bk_temp);
        
        for k=1:id_num % going through identities
            if isempty(cellIn{k,i})
            else
                sizeValue=size(cellIn{k,i},1)*size(cellIn{k,i},2);
                temp=bk_temp(1:sizeValue);
                bk_temp(1:sizeValue)=[];
                output{k,i}(:,:,j)=reshape(temp,size(cellIn{k,i},1),...
                    size(cellIn{k,i},2));
            end
        end
    end
end
