%% within blocks
% size of lwdata.data: 2    62     1     1     1   512
% size of output matrix: cell images X blocks
output=cell(159,30);
ind=NaN(159,30);
for i=1:size(lwdata,2)
    name=lwdata(i).header.name;
    id1=strfind(name,'idn');
    id1=id1(1);
    id2=strfind(name,'bck');
    id=str2double(name(1,id1+4:id2-41));
    bk1=strfind(name,'blk');
    bk2=strfind(name,'icfilt');
    bk=str2double(name(1,bk1+4:bk2(1)-2));
    data=lwdata(i).data;
    data=reshape(data,size(data,1),size(data,2),size(data,6));
%     data=squeeze(data);
    output{id,bk}=data;
    ind(id,bk)=size(output{id,bk},1);
end %2    62     1     1     1   512
output(60:100,:)=[];
ind(60:100,:)=[];



output_new=cell(118,16);
for j=1:118
    for i=1:16
        a=output1{j,i};
        b=output1{j,i+16};
        c=cat(1,a,b);
        output_new{j,i}=c;
    end
end

output_new(:,4)=[];
%% within blocks
% output_all=cell(159,1);
% ind_all=NaN(159,1);
% for i=1:size(lwdata,2)
%     name=lwdata(i).header.name;
%     id1=strfind(name,'ep ');
%     id1=id1(1);
%     id2=strfind(name,'diff');
%     id=str2double(name(1,id1+3:id2-2));
%     bk2=strfind(name,'reref ic');
%     bk=str2double(name(1,id2+24:bk2(1)-2));
%     data=lwdata(i).data;
%     data=mean(data,1);
%     output_all{id}=cat(3,output_all{id},data);
%     ind_all(id)=size(output_all{id},1);
% end %2    62     1     1     1   512
% % ep 1 same zsc blk ar bl idn b01 reref icfilt ica but ep 500 chs'
% output_all=output_all(~cellfun('isempty',output_all));
% out=NaN(118,62,15,512);
% for i=1:size(output_all,1)
%     output_all{i}=squeeze(output_all{i});
%     out(i,:,:,:)=output_all{i};
% end
% %% between blocks
% output_all=cell(159,1);
% output_bk1=cell(159,1);
% output_bk2=cell(159,1);
% ind_all=NaN(159,1);
% ind_bk1=NaN(159,1);
% ind_bk2=NaN(159,1);
% for i=1:size(lwdata,2)
%     name=lwdata(i).header.name;
%     id1=strfind(name,'idn');
%     id2=strfind(name,'bck');
%     id=str2double(name(1,id1+4:id2-2));
%     bk2=strfind(name,'reref ic');
%     bk=str2double(name(1,id2+5:bk2(1)-2));
%     data=lwdata(i).data;
%     output_all{id}=cat(1,output_all{id},data);
%     ind_all(id)=size(output_all{id},1);
%     if bk<16
%         output_bk1{id}=cat(1,output_bk1{id},data);
%         ind_bk1(id)=size(output_bk1{id},1);
%     else
%         output_bk2{id}=cat(1,output_bk2{id},data);
%         ind_bk2(id)=size(output_bk2{id},1);
%     end
% end
% output_all=output_all(~cellfun('isempty',output_all));
% minInd_all=min(ind_all);
% output_bk1=output_bk1(~cellfun('isempty',output_bk1));
% minInd_bk1=min(ind_bk1);
% output_bk2=output_bk2(~cellfun('isempty',output_bk2));
% minInd_bk2=min(ind_bk2);
% out_all=NaN(size(output_all,1),minInd_all,size(output_all{1},2),size(output_all{1},6));
% out_bk1=NaN(size(output_all,1),minInd_bk1,size(output_all{1},2),size(output_all{1},6));
% out_bk2=NaN(size(output_all,1),minInd_bk2,size(output_all{1},2),size(output_all{1},6));
% for i=1:size(output_all,1)
%     data=squeeze(output_all{i});
%     b=randperm(size(data,1));
%     b=b(1:minInd_all);
%     b=sort(b);
%     data=data(b,:,:);
%     out_all(i,:,:,:)=data;
%     
%     data=squeeze(output_bk1{i});
%     b=randperm(size(data,1));
%     b=b(1:minInd_bk1);
%     b=sort(b);
%     data=data(b,:,:);
%     out_bk1(i,:,:,:)=data;
%     
%     data=squeeze(output_bk2{i});
%     b=randperm(size(data,1));
%     b=b(1:minInd_bk2);
%     b=sort(b);
%     data=data(b,:,:);
%     out_bk2(i,:,:,:)=data;
%     
% end
%     