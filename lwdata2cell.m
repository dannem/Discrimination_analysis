function [output,ind]=lwdata2cell(lwdata,firstId,secondId,firstBlock,secondBlock)
% function convert lwdata data containing separate identities and blocks of
% an individual subject into a cell array (identities X blocks), where each
% cell contains trials, times, eclectores etc.
% Inputs - prefixes and suffixes before and after trial and id numbers.
% E.g.:
% firstId='idt';
% secondId='ar';
% firstBlock='blk';
% secondBlock='icfilt';
% Outputs: output - output matrix, ind - number of trials per block and id
% Created by DN for AN Lab
firstIdLength=length(firstId);
firstBlockLength=length(firstBlock);
% output=cell(159,30);
% ind=NaN(159,30);
for i=1:size(lwdata,2)
    name=lwdata(i).header.name;
    id1=strfind(name,firstId);
    id2=strfind(name,secondId);
    id=str2double(name(1,id1(1)+firstIdLength:id2(1)-1));
    bk1=strfind(name,firstBlock);
    bk2=strfind(name,secondBlock);
    bk=str2double(name(1,bk1(1)+firstBlockLength:bk2(1)-2));
    if bk>599 && bk<699
        bk=bk-599;
    elseif bk>699 && bk<799
        bk=bk-699+17;
    end
    data=lwdata(i).data;
    data=reshape(data,size(data,1),size(data,2),size(data,6));
%     data=squeeze(data);
    output{id,bk}=data;
    ind(id,bk)=size(output{id,bk},1);
end %2    62     1     1     1   512
a=cellfun(@isempty, output);
output(find(a(:,1)>0),:)=[];
ind(find(a(:,1)>0),:)=[];
