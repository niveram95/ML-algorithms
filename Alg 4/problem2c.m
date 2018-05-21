train =load('optdigits49_train.txt');
test = load('optdigits49_test.txt');
theclass1 = train(:,end);
train = train(:,1:end-1);
theclass2 = test(:,end);
test = test(:,1:end-1);

disp('Error on digits49 train:');
[alpha, b] = kernPercGD(train, theclass1);
poly = (test*(train.')).^2;
res = poly*(alpha.*theclass1) + b;
e= sum(sign(res)~=theclass2);
disp('Error on digits49 test');disp(e*100/size(test,1));

train = load('optdigits79_train.txt');
test = load('optdigits79_test.txt');
theclass1 = train(:,end);
train = train(:,1:end-1);
theclass2 = test(:,end);
test = test(:,1:end-1);

disp('Error on digits79 train:');
[alpha, b] = kernPercGD(train, theclass1);
poly = (test*(train.')).^2;
res = poly*(alpha.*theclass1) + b;
e= sum(sign(res)~=theclass2);
disp('Error on digits79 test');disp(e*100/size(test,1));