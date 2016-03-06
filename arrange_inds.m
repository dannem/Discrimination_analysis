function output=arrange_inds(inCell)
% inCell is cell with the eeg (ims X blocks);
% new order of images: happy1,neutral1,happy2,neutral2...
output=cell(size(inCell));
imageNum=size(inCell,1);
idnsNum=imageNum/2;

for i=1:idnsNum
    output(i*2,:)=inCell(i+idnsNum,:);
    output(i*2-1,:)=inCell(i,:);
end