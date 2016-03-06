perm_data=squeeze(data.perm_dprRes);
true_data=squeeze(data.true_mat_dprRes);

%%preparing data
temp=sort(mean(mean(perm_data,4),3));
true=mean(mean(true_data,3),2);
rank=zeros(1,size(temp,2));
for i=1:size(temp,2)
    ind=[];
    ind=find(true(i)<temp(:,i));
    if isempty(ind)
        ind=0.001;
    else
        ind=ind(1)/size(temp,1);
    end
    rank(i)=ind;
end
    
[pID,pN, pID_cnt, pN_cnt] = FDR_comp(rank,0.05);
data.pID=pID;
data.pN=pN;
data.pID_cnt=pID_cnt;
data.pN_cnt=pN_cnt;
data.rank=rank;
save([data.name '_' datestr(now, 'dd-mmm-yyyy')  '.mat'],'data')
    
