function output=zscore_across_elecs_time(cellIn)
output=cell(size(cellIn));
tim_bin=size(cellIn{1,1},3);
id_num=size(cellIn,1);
bck_num=size(cellIn,2);
for i=1:bck_num %going through blocks
    for j=1:id_num %images
        temp=cellIn{j,i};
        s1=size(temp,1);
        s2=size(temp,2);
        s3=size(temp,3);
        temp=reshape(temp,s1,s2*s3);
        temp=zscore(temp');
        temp=reshape(temp',s1,s2,s3);
        output{j,i}=temp;
    end
end
        