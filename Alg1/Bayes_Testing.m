function [error]=Bayes_Testing(test_data,p1,p2,pc1,pc2)
[Test,n]=size(test_data);
z=zeros(1,n-1);
y=zeros(1,n-1);
result=zeros(1);
for i=1:Test
    c=test_data(i,n);
        if(c==1)
            z=z+test_data(i,1:n-1);
        else y=y+test_data(i,1:n-1);
        end
end
pp1=z/sum(test_data(:,n)==1);pp2=y/sum(test_data(:,n)==2);
for i=1:Test %Testing the best prior values on the test data
    x=test_data(i,1:n-1);
    p1=prod((pp1.^x).*((1-pp1).^(1-x)))*pc1;p2=prod((pp2.^x).*((1-pp2).^(1-x)))*pc2;
    if p1>p2 
        result(i)=1;
    else result(i)=2;
    end   
end
r=(result'==test_data(:,n));error=sum(r==0)/Test*100;
sprintf('Error rate on testing data: %0.7f',error)

