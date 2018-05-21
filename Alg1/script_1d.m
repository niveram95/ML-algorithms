%Problem 1d
a=load('SPECT_train.txt');
b=load('SPECT_valid.txt');
test_data=load('SPECT_test.txt');
[c,d,e,f]=Bayes_Learning(a,b);%Running Bayes_Learning
x=Bayes_Testing(test_data,c,d,e,f);%Running Bayes_Testing

