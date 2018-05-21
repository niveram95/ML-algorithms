train=load('optdigits_train.txt');
test=load('optdigits_test.txt');
modes1=myKNN(train,test,1);
modes2=myKNN(train,test,3);
modes3=myKNN(train,test,5);
modes4=myKNN(train,test,7);