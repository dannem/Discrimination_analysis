function output=zscore_across_elecs_only(cellIn)
output=cell(size(cellIn));
tim_bin=size(cellIn{1,1},3);
id_num=size(cellIn,1);
bck_num=size(cellIn,2);
for i=1:bck_num %going through blocks
    for j=1:id_num %images
        temp=cellIn{j,i};
        trial_num=size(temp,1);
        for k=1:trial_num % going through trials
            for n=1:tim_bin % going through time poins
                temp(k,:,n)=zscore(squeeze(temp(k,:,n)));
            end
        end
        output{j,i}=temp;
    end
end
        