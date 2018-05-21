training_data=load('optdigits_train.txt');
test_data=load('optdigits_test.txt');
train= training_data(:,1:64);
test= test_data(:,1:64);
ct= cov(train);
[a,b] = eig(ct);
d = diag(b);s1=sum(d);
[d,index] = sort(d,'descend');
a=a(:,index);
val=0.5;count=1;t1=0;
v1=[];ind=[];
glob1 = mean(train);
glob2 = mean(test);
while(val<0.9)
    t1=t1+d(count);
    val=(t1)/s1;
    v1=[v1;val];
    count=count+1;
    ind=[ind;count];
end
count=count-1;
figure;plot(ind(2:count),v1(2:count),'g-+');
[vector,eigval]=myPCA(training_data,count);%Calling the function myPCA
train1=bsxfun(@minus,train,glob1)*vector;
test1=bsxfun(@minus,test,glob2)*vector;
Train = [train1(:,:) training_data(:,65)];
Test = [test1(:,:) test_data(:,65)];
res1 = myKNN(Train,Test,1);
res2 = myKNN(Train,Test,3);
res3 = myKNN(Train,Test,5);
res4 = myKNN(Train,Test,7);