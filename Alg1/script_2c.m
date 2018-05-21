training_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
[vector,~]=myPCA(training_data,2);
train = training_data(:,1:64);
test = test_data(:,1:64);
glob1 = mean(train);
glob2 = mean(test);
t1=bsxfun(@minus,train,glob1)*vector;
t2=bsxfun(@minus,test,glob2)*vector;
Train = [t1(:,:) training_data(:,65)];
Test = [t2(:,:) test_data(:,65)];
figure;
scatter(Train(:,1),Train(:,2),25,Train(:,3),'filled');
hold on;
%scatter(Test(:,1),Test(:,2),25,Test(:,3),'filled');
for i=1:1500
    txt1=num2str(Train(i,3));
    text(Train(i,1)+0.1,Train(i,2)+0.1,txt1);
end
for i=1:297
    txt1=num2str(Test(i,3));
    text(Test(i,1)+0.1,Test(i,2)+0.1,txt1);
end