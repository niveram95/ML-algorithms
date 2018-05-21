function [alpha,b]=kernPercGD(train_data,train_label)

n=size(train_data,1);
alpha=zeros(n,1);
temp=zeros(n,1);
p=0;
e=[];
errd=100;
pre_err= 0;
b=0;
poly = (train_data*(train_data.')).^2;%Using degree 2 for kernel

while abs(errd)>1 %Convergence
   
    for i=1:n
        temp(i,1)=(sum(alpha.*train_label.*poly(:,i))+b)*train_label(i,1);
        if temp(i,1)<=0
            alpha(i,1)=alpha(i,1)+1;
            b=b+train_label(i,1);
        end
    end
    
    p=p+1;    
    res = poly*(alpha.*train_label) + b;
    e(p)= sum(sign(res)~=train_label);
    errd= e(p)-pre_err;pre_err=e(p);
    
end
disp('Error rate%: ');disp((e(end)*100)/size(train_data,1));
end