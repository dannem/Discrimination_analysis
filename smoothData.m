myfilter = fspecial('gaussian',[1,20], 0.5);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat05=mat;          


myfilter = fspecial('gaussian',[1,20], 0.8);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat08=mat;  


myfilter = fspecial('gaussian',[1,20], 1);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat1=mat; 


myfilter = fspecial('gaussian',[1,20], 1.5);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat15=mat; 

myfilter = fspecial('gaussian',[1,20], 2);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat2=mat;      


myfilter = fspecial('gaussian',[1,20], 3);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat3=mat;  


myfilter = fspecial('gaussian',[1,20], 5);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=imfilter(squeeze(data.mat(i,j,z,:)), myfilter, 'replicate');
        end
    end
end
data.mat5=mat;     

myfilter = fspecial('gaussian',[1,20], 5);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=conv(squeeze(data.mat(i,j,z,:)), myfilter, 'same');
        end
    end
end
data.mat5c=mat;  

myfilter = fspecial('gaussian',[1,20], 2);
mat=zeros(size(data.mat));
for i=1:size(data.mat,1)
    for j=1:size(data.mat,2)
        for z=1:size(data.mat,3)
            mat(i,j,z,:)=conv(squeeze(data.mat(i,j,z,:)), myfilter, 'same');
        end
    end
end
data.mat2c=mat;        