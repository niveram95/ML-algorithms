function [ h,M,Q] = EMG(flag,img,k)
[ima,cmap]= imread(img);
img_rgb =ind2rgb(ima,cmap);
img_double=im2double(img_rgb);
X=reshape(img_double, [],3);
N=size(X,1);[id, M]=kmeans(X,k,'Distance','sqeuclidean','MaxIter',3,'EmptyAction','singleton');
final=zeros(N,3);
var=10^-7;
for i= 1:k
    Sigma(:,:,i)=cov(X(id(:)==i,:));
    try
        pvalue(:,i)=mvnpdf(X,M(i,:),Sigma(:,:,i));
    catch
    end
    pi(i)= sum(id(:)==i)/N;    
end
for i1=1:100
    for i=1:k
        temp3=inv(Sigma(:,:,i));
        determinant=det(Sigma(:,:,i));
        for j=1:N
            h(j,i)=pi(i).*(determinant)^(-0.5)*exp((-0.5)*(X(j,:)-M(i,:))*temp3*(X(j,:)-M(i,:))');
        end
    end
    h=bsxfun(@rdivide, h, sum(h,2));Ni=sum(h);
    %E step
    pvalue(pvalue==0)=var;pi(pi==0)=var;
    Q(i1,1)=sum(h)*(log(pi))'+sum(sum(h.*log(pvalue)));
    M=bsxfun(@rdivide,(h')*X, Ni');l=0.005;
    for i=1:k
        Sigma(:,:,i)=transpose(X-repmat(M(i,:),N,1))*((X-repmat(M(i,:),N,1)).*repmat(h(:,i),1,3));
        I=eye(size(Sigma(:,:,i),1));
        %Adding the regularization term for goldy when there is an error and when the flag is set
        if(flag==0)
            Sigma(:,:,i)=Sigma(:,:,i)./Ni(i);
        else
        Sigma(:,:,i)=Sigma(:,:,i)./Ni(i)+(l*I)./Ni(i);
        end
    end
    err=0;
    try
        for i=1:k
            pvalue(:,i)=mvnpdf(X,M(i,:),Sigma(:,:,i));
        end        
    catch me
        err=1;
    end
    %M step 
    pvalue(pvalue==0)=var;pi(pi==0)=var; 
    te=log(pvalue);Q(i1,2)=sum(h)*(log(pi))'+sum(sum(h.*te)); 
end
[t1,t2] = max(h, [], 2 );
for i=1:N
    final(i,:)=M(t2(i),:);
end
final=reshape(final, size(img_rgb,1),size(img_rgb,2),3); figure;
imagesc(final); %Displaying the compressed image
end
