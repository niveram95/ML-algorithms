function main
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
axis=0.5:0.5:150;axis1=0.5:1:149.5;axis2=1:1:150;
plot(axis,Q4(:)');hold all;
scatter(axis1,Q4(:,1),'MarkerEdgeColor',[0 .5 .5],...
    'LineWidth',1.5)
scatter(axis2,Q4(:,2),'MarkerEdgeColor',[1 .8 .8],...
    'LineWidth',1.5);
hold off;
%k=8
figure
plot(axis,Q8(:)');hold all;
scatter(axis1,Q8(:,1),'MarkerEdgeColor',[0 .5 .5],...
    'LineWidth',1.5)
scatter(axis2,Q8(:,2),'MarkerEdgeColor',[1 .8 .8],...
    'LineWidth',1.5);
hold off;
%k=12
figure
plot(axis,Q12(:)');hold all;
scatter(axis1,Q12(:,1),'MarkerEdgeColor',[0 .5 .5],...
    'LineWidth',1.5)
scatter(axis2,Q12(:,2),'MarkerEdgeColor',[1 .8 .8],...
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
[a,b]= imread('goldy.bmp');
img=im2double(ind2rgb(a,b));
[idx, M]=kmeans(reshape(img, [],3),7);
siz=size(reshape(img, [],3),1);
final=zeros(siz,3);
for i=1:siz
    final(i,:)=M(idx(i),:);
end
final=reshape(final, size(temp,1),size(temp,2),3);figure;
imagesc(final);

%PART E:
%Implement the refined EM algorithm 
flag=1;
[ h7,M7,Q7] = EMG(flag,'goldy.bmp',7);
end