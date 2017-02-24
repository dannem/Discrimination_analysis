function input=scale01(input)
%% scales the matrix within 0 and 1 range of the 1st dimension
for i=1:size(input,2)
    for j=1:size(input,3)
        for k=1:size(input,4)
            for g=1:size(input,5)
                temp=squeeze(input(:,i,j,k,g));
                temp=(temp-min(temp))/max(temp);
                input(:,i,j,k,g)=temp;
            end
        end
    end
end
              