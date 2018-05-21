function [vector,eigval]=myLDA(data,num_principal_components)
train = data(:,1:size(data,2)-1);
M=mean(train);
mean1=[];N=[];
sw=0;
sb=0;
for i=0:9
    temp{i+1}=0;
    ind=data(:,65)==i;
    A0=train(ind,:);
    mean1=mean(A0);
    N=size(A0,1);
    for j=1:N
        temp{i+1}=temp{i+1}+(A0(j,:)-mean1)'*(A0(j,:)-mean1);
    end
    sw=sw+temp{i+1};
    sb=sb+N*(mean1-M)'*(mean1-M);
end
A=pinv(sw)*sb;
[vecs,vals] = eig(A);
diagonal = diag(vals);

[diagonal,index] = sort(diagonal, 'descend');
eigval=diagonal(1:num_principal_components);
vecs=vecs(:,index);
vector=vecs(:,1:num_principal_components);


 