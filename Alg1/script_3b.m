tr = load('face_train_data_960.txt');
te = load('face_test_data_960.txt');
s=size(tr,2);
train = tr(:,1:s-1);test = te(:,1:s-1);
ct =  cov(train);
[v,b] = eig(ct);
diagonal = diag(b);
sd=sum(diagonal);
[diagonal,index]=sort(diagonal,'descend');
v=v(:,index);
n1=0.5;count=1;sum=0;
res=zeros(1,1);
ind=zeros(1,1);
glob1 = mean(train);
glob2 = mean(test);
while(n1<0.9)
    sum=sum+diagonal(count);
    n1=(sum)/sd;
    res=[res;n1];
    %disp(val);
    count=count+1;
    ind=[ind;count];
end
count=count-1;
figure;plot(ind(2:count),res(2:count),'r-+');
[vec,~]=myPCA(tr,count);%Calling the function myPCA
train1=bsxfun(@minus,train,glob1)*vec;
test1=bsxfun(@minus,test,glob2)*vec;
A = [train1(:,:) tr(:,s)];B = [test1(:,:) te(:,s)];
r1 = myKNN(A,B,1);r2 = myKNN(A,B,3);r3 = myKNN(A,B,5);r4 = myKNN(A,B,7);