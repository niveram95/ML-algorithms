train_data = load('optdigits_train.txt');
test_data = load('optdigits_test.txt');
train = train_data(:,1:size(train_data,2)-1);
test = test_data(:,1:size(test_data,2)-1);
[a1,~]=myLDA(train_data,2);
[a2,~]=myLDA(train_data,4);
[a3,~]=myLDA(train_data,9);

disp('L=');disp('2');
z1_train=(train)*a1;
z1_test=(test)*a1;
Tr1 = [z1_train(:,:) train_data(:,65)];
Te1 = [z1_test(:,:) test_data(:,65)];
myKNN(Tr1,Te1,1);
myKNN(Tr1,Te1,3);
myKNN(Tr1,Te1,5);

disp('L=');disp('4');
z1_train=(train)*a2;
z1_test=(test)*a2;
Tr1 = [z1_train(:,:) train_data(:,65)];
Te1 = [z1_test(:,:) test_data(:,65)];
myKNN(Tr1,Te1,1);
myKNN(Tr1,Te1,3);
myKNN(Tr1,Te1,5);

disp('L=');disp('9');
z1_train=(train)*a3;
z1_test=(test)*a3;
Tr1 = [z1_train(:,:) train_data(:,65)];
Te1 = [z1_test(:,:) test_data(:,65)];
myKNN(Tr1,Te1,1);
myKNN(Tr1,Te1,3);
myKNN(Tr1,Te1,5);

