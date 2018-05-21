% CSCI 5521 Introduction to Machine Learning
%PROBLEM 3


%Preparing the data, finding mean, covariance and other intermediates to be
%used in the equation.
A=importdata('training_data.txt',',');
train1=A(A(:,9)==1 , :);
train2=A(A(:,9)==2 , :);
train1=train1(:,1:8);
train2=train2(:,1:8);
A=importdata('test_data.txt',',');
mtemp1=mean(train1); disp('Mean1');disp(mtemp1);
mtemp2=mean(train2); disp('Mean2');disp(mtemp2);
c1=cov(train1); disp('Learned S values for part 3a');disp('S1:');disp(c1);
c2=cov(train2); disp('S2:');disp(c2);
cinv1=inv(c1);
cinv2=inv(c2);
detcov1=det(c1);
detcov2=det(c2);
%Intermediates to be used in the determinant function
temp1a=-0.5*log(detcov1); 
temp1b=-0.5*log(detcov2);
temp2a=log(0.6);        
temp2b=log(0.4);
B=A(:,1:8); 

errora=0;errorb=0;errorc=0;errord=0;
%Part 3a: Independent S1 and S2
C=zeros(size(A));
for i=1:100
    class1=temp1a-0.5*(B(i,:)-mtemp1)*cinv1*(B(i,:)-mtemp1)'+temp2a;
    class2=temp1b-0.5*(B(i,:)-mtemp2)*cinv2*(B(i,:)-mtemp2)'+temp2b;
    C(i,1:8)=B(i,:);
    if(class1>class2)
        C(i,9)=1;
    
    else C(i,9)=2;
    end
end
sum=0;
%Calculating error
for i=1:100
    sum=sum+abs(A(i,9)-C(i,9));
end
errora=sum; %error of 3a

%Part 3b: Assume S1=S2
C=zeros(size(A));
% We use a cumulative c involving both the covariances along with their probabilities
c=(0.6*c1)+(0.4*c2); disp('Learned S value for part 3b');disp('S');disp(c);
cdet=det(c);
cinv=inv(c);
temp1a=-0.5*log(cdet);
temp1b=-0.5*log(cdet);
for i=1:100
    class1=temp1a-0.5*(B(i,:)-mtemp1)*cinv*(B(i,:)-mtemp1)'+temp2a;
    class2=temp1b-0.5*(B(i,:)-mtemp2)*cinv*(B(i,:)-mtemp2)'+temp2b;
    C(i,1:8)=B(i,:);
    if(class1>class2)
        C(i,9)=1;
    
    else C(i,9)=2;
    end
end
sum=0;
for i=1:100
    sum=sum+abs(A(i,9)-C(i,9));
end

errorb=sum; %Error of 3b

%Part 3c: Assume S1 and S2 are diagonal
%Forming a diagonal matrix of c1 and c2 where all the values other than the
%diagonal is zero.
ct1=diag(diag(c1)); disp('Learned S values for part 3c');disp('S1:');disp(ct1);
ct2=diag(diag(c2)); disp('S2:');disp(ct2);
ctdet1=det(ct1);
ctdet2=det(ct2);
ctinv1=inv(ct1);
ctinv2=inv(ct2);
temp1a=-0.5*log(ctdet1);
temp1b=-0.5*log(ctdet2);
C=zeros(size(A));
for i=1:100
    class1=temp1a-0.5*(B(i,:)-mtemp1)*ctinv1*(B(i,:)-mtemp1)'+temp2a;
    class2=temp1b-0.5*(B(i,:)-mtemp2)*ctinv2*(B(i,:)-mtemp2)'+temp2b;
    C(i,1:8)=B(i,:);
    if(class1>class2)
        C(i,9)=1;
    
    else C(i,9)=2;
    end
end
sum=0;
for i=1:100
    sum=sum+abs(A(i,9)-C(i,9));
end
errorc=sum;
%Part 3d: Assume S1 and S2 are diagonal and shared
%Forming a diagonal matrix of c1 and c2 and finding the mean of the
%diagonal elements. 
p1=mean(train1);
p2=mean(train2);
mtemp1=mean(diag(c1)); 
mtemp2=mean(diag(c2)); 
ctt1=zeros(8,8);ctt2=zeros(8,8);
ctt1(logical(eye(8)))=mtemp1;ctt2(logical(eye(8)))=mtemp2;
ctdet1=det(ctt1);
disp('Learned S values for part 3d');disp('Alpha1');disp(mtemp1);
disp('Alpha2');disp(mtemp2);
ctdet2=det(ctt2);
ctinv1=inv(ctt1);
ctinv2=inv(ctt2);
temp1a=-0.5*log(ctdet1);
temp1b=-0.5*log(ctdet2);
C=zeros(size(A));
for i=1:100
    class1=temp1a-0.5*(B(i,:)-p1)*ctinv1*(B(i,:)-p1)'+temp2a;
    class2=temp1b-0.5*(B(i,:)-p2)*ctinv2*(B(i,:)-p2)'+temp2b;
    C(i,1:8)=B(i,:);
    if(class1>class2)
        C(i,9)=1;
    
    else C(i,9)=2;
    end
end
sum=0;
for i=1:100
    sum=sum+abs(A(i,9)-C(i,9));
end
errord=sum;


disp('Error1: ');disp(errora);
disp('Error2: ');disp(errorb);
disp('Error3: ');disp(errorc);
disp('Error4: ');disp(errord);
