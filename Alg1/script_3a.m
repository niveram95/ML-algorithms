train_data = load('face_train_data_960.txt');
test_data = load('face_test_data_960.txt');
d=[train_data;test_data];
[vector,eigval]=myPCA(d,5);
figure;
for i=1:5
subplot(3,2,i),imagesc(reshape(vector(:,i),32,30)');
end