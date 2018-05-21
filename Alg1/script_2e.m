train_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
train = train_data(:,1:size(train_data,2)-1);
test = test_data(:,1:size(test_data,2)-1);
[a1,~]=myLDA(train_data,2);
z1_train=(train)*a1;
z1_test=(test)*a1;
Tr1 = [z1_train(:,:) train_data(:,65)];
Te1 = [z1_test(:,:) test_data(:,65)];
scatter(Tr1(:,1),Tr1(:,2),25,Tr1(:,3),'filled');
hold on;
scatter(Te1(:,1),Te1(:,2),25,Te1(:,3),'filled');
for i=1:1500
    txt1=num2str(Tr1(i,3));
    text(Tr1(i,1),Tr1(i,2),txt1);
end
for i=1:297
    txt1=num2str(Te1(i,3));
    text(Te1(i,1),Te1(i,2),txt1);
end