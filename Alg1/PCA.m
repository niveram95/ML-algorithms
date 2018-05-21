function []myPCA(training_data,test_data,num_principal_components)
train = training_data(:,1:64);
test = test_data(:,1:64);
global_mean_train = mean(train);
global_mean_test = mean(test);
covariance_train =  cov(train);
[vecs,vals] = eig(covariance_train);
diag_vals = diag(vals);
sum_diag_vals=sum(diag_vals);
[diag_vals,index] = sort(diag_vals, 'descend');
vecs=vecs(:,index);
val=0;i=1;temp=0;
valmat=zeros(1,1);
imat=zeros(1,1);
while(val<0.9)
    temp=temp+diag_vals(i);
    val=(temp)/sum_diag_vals;
    valmat=[valmat;val];
    %disp(val);
    i=i+1;
    imat=[imat;i];
end
i=i-1;
figure;
plot(imat(2:i),valmat(2:i),'b-+');
W=vecs(:,1:i);

z_train=bsxfun(@minus,train,global_mean_train)*W;
z_test=bsxfun(@minus,test,global_mean_test)*W;

Tr = [z_train(:,:) training_data(:,65)];
Te = [z_test(:,:) test_data(:,65)];

r = KNN(Tr,Te,5);
