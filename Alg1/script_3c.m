tr = load('face_train_data_960.txt');
te = load('face_test_data_960.txt');
s=size(tr,2);train = tr(:,1:s-1);test = te(:,1:s-1);
[vec1,~]=myPCA(tr,10);[vec2,~]=myPCA(tr,50);[vec3,~]=myPCA(tr,100);
glob = mean(train);
zt1=bsxfun(@minus,train,glob)*vec1;
zt2=bsxfun(@minus,train,glob)*vec2;
zt3=bsxfun(@minus,train,glob)*vec3;
vector1=bsxfun(@plus,zt1*(vec1)',glob);
vector2=bsxfun(@plus,zt2*(vec2)',glob);
vector3=bsxfun(@plus,zt3*(vec3)',glob);
figure;
for i=1:5   
    subplot(2,3,i),imagesc(reshape(vector1(i,:),32,30)');
end
 figure;
for i=1:5    
    subplot(2,3,i),imagesc(reshape(vector2(i,:),32,30)');
end
 figure;
for i=1:5
    subplot(2,3,i),imagesc(reshape(vector3(i,:),32,30)');
end

