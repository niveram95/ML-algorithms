
function problem2c(w)
te='optdigits_test.txt';
test=load(te);

co=[ones(size(test,1),1) test(:,1:end-1)];
z1=co*w';
A = pca(z1);
z1dash2d = z1*A(:,1:2);
figure;
%color=[0.2 1 0.6; 1 0 1; 0 1 1; 1 0 0; .2 .6 1; 1 1 1; 1 .6 .2; 0 .6 1; 1 .2 .6; .2 1 .6];
for k=0:9
    z_group= z1dash2d(test(:,end)==k,:);
    scatter(z_group(:,1),z_group(:,2),'filled','d');
    hold on;
end

for i=1:100
    txt=num2str(test(i,65));
    text(z1dash2d(i,1),z1dash2d(i,2),txt);
end
figure;
zdash3d = z1*A(:,1:3);
for k=0:9
    z_group= zdash3d(test(:,end)==k,:);
    scatter3(z_group(:,1),z_group(:,2),z_group(:,3),'filled','d');
    hold on;
end

for i=1:300
    txt=num2str(test(i,65));
    text(zdash3d(i,1),zdash3d(i,2),zdash3d(i,3),txt);
end
end