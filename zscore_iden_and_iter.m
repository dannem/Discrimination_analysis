function output=zscore_iden_and_iter(input,thrshld)
for i=1:size(input,2)
    for j=1:size(input{1,1},3)
        for b=1:size(input{1,1},2)
            vec=[];
            for k=1:size(input,1)
                temp=input{k,i}(:,b,j);
                ind(k)=size(temp,1);
                vec=[vec; temp];
            end
            vec=zscore(vec);
            if nargin>1
                vec(vec>thrshld)=thrshld;
                vec(vec<(-1*thrshld))=-1*thrshld;
            end
            for k=1:size(input,1)
                temp=vec(1:ind(k),1);
                vec(1:ind(k))=[];
                input{k,i}(:,b,j)=temp;
            end
        end
    end
end
output=input;