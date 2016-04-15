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
        counter=1;
        for k=1:id_num % going through identities
            vec_size=id(k)*elc_num;
            temp=bk_temp(counter:counter+vec_size-1);
            temp=reshape(temp,id(k),elc_num,1);
            output{k,i}=cat(3,output{k,i},temp);
            counter=counter+vec_size;
        end
    end
end
        