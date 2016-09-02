cumData=[];
for i=1:size(results,1)
    temp=results(i,:);
    cumData(temp(4)).data(temp(3),temp(2))=temp(1);
    
end
for i=1:size(cumData,2)
    cumData(i).data( :, ~any(cumData(i).data,1) ) = []; 
    temp=disc(i,:);
    temp=temp(~cellfun('isempty',temp));
    cumData(i).disc=temp;
end

cumData(1).id=10;
cumData(2).id=11;
cumData(3).id=12;
cumData(4).id=13;
cumData(5).id=14;
cumData(5:9)=cumData1;

%% preparing for confusability matrix
ind=perm_separation(60,54);
for i=1:size(cumData,2)
    tempH(i,:)=squeeze(cumData(1).disc{1, 77}.ap(1,1,ind.indOne));%taking disc at 650 ms
    tempN(i,:)=squeeze(cumData(1).disc{1, 77}.ap(1,2,ind.indOne));
end
disc_hap=mean(tempH(1:8,:));% excluding sub 14
disc_neut=mean(tempN(1:8,:));
%% Plotting
timeline=linspace(50,650,77);
figure
subplot(2,1,1)
for i=1:size(cumData,2)
plot(timeline,cumData(i).data(1,:));
leg{i}=num2str(num2str(cumData(i).id));
hold on
end
legend(leg);
suptitle('Happy')


subplot(2,1,2)
for i=1:size(cumData,2)
plot(timeline,cumData(i).data(2,:));
leg{i}=num2str(num2str(cumData(i).id));
hold on
end
legend(leg);
suptitle('Neutral')

%% computing correlations
ind=perm_separation(60,54);
numBins=size(cumData(1).data,2);
subsNum=9;
pairs = nchoosek(1:subsNum,2);
output=NaN([2 numBins subsNum subsNum]);
for i=1:numBins
  for j=1:size(pairs,1)
      for k=1:2
          temp1=squeeze(cumData(1,pairs(j,1)).disc{1, i}.ap(1,k,:));
          temp1=temp1(ind.indOne);
          temp2=squeeze(cumData(1,pairs(j,2)).disc{1, i}.ap(1,k,:));
          temp2=temp2(ind.indOne);
          output(k,i,pairs(j,2),pairs(j,1))=corr(temp1,temp2);
          output(k,i,pairs(j,1),pairs(j,2))=corr(temp1,temp2); 
      end
  end
end
for i=1:numBins
    sumH(i)=nanmean(nanmean(output(1,i,:,:),4),3);
    sumN(i)=nanmean(nanmean(output(2,i,:,:),4),3);
end