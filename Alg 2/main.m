function main
%Clear all variables before starting
%PART A:Plotting the compressed image and finding the h,M,Q values for each k value=4,8,12
flag=0;
for count=1:3
    if(count==1)
       [ h4,M4,Q4] = EMG(flag,'stadium.bmp',4);
    elseif(count==2)
       [ h8,M8,Q8] = EMG(flag,'stadium.bmp',8);
    else 
       [ h12,M12,Q12] = EMG(flag,'stadium.bmp',12);
    end
end

%PART B: Plotting the log likelihood function of each of the k value.
%k=4
figure
axis=0.5:0.5:100;axis1=0.5:1:99.5;axis2=1:1:100;
temp4=transpose(Q4);
plot(axis,temp4(:));hold all;
scatter(axis1,Q4(:,1),'MarkerEdgeColor','b',...
    'LineWidth',1.5)
scatter(axis2,Q4(:,2),'MarkerEdgeColor','r',...
    'LineWidth',1.5);
hold off;
%k=8
figure
temp8=transpose(Q8);
plot(axis,temp8(:));hold all;
scatter(axis1,Q8(:,1),'MarkerEdgeColor','b',...
    'LineWidth',1.5)
scatter(axis2,Q8(:,2),'MarkerEdgeColor','r',...
    'LineWidth',1.5);
hold off;
%k=12
figure
temp12=transpose(Q12);
plot(axis,temp12(:));hold all;
scatter(axis1,Q12(:,1),'MarkerEdgeColor','b',...
    'LineWidth',1.5)
scatter(axis2,Q12(:,2),'MarkerEdgeColor','r',...
    'LineWidth',1.5);
hold off;

%PART C:
%Implement EM on goldy with k=7 which leads to an error
err=0;
try
   [ h7,M7,Q7] = EMG(flag,'goldy.bmp',7);
catch me
    err=1;
end
%Using KMeans function to display compressed image
[ima,cmap]= imread('goldy.bmp');
img_rgb =ind2rgb(ima,cmap);
img_double=im2double(img_rgb);
goldy=reshape(img_double, [],3);
[idx, M]=kmeans(goldy,7);
N=size(goldy,1);
final=zeros(N,3);
for i=1:N
    final(i,:)=M(idx(i),:);
end
final=reshape(final, size(img_rgb,1),size(img_rgb,2),3);
figure;
imagesc(final);

%PART E:
%Implement the refined EM algorithm 
flag=1;
[ h7,M7,Q7] = EMG(flag,'goldy.bmp',7);
figure
temp7=transpose(Q7);
plot(axis,temp7(:));hold all;
scatter(axis1,Q7(:,1),'MarkerEdgeColor','b',...
    'LineWidth',1.5)
scatter(axis2,Q7(:,2),'MarkerEdgeColor','r',...
    'LineWidth',1.5);
hold off;
end