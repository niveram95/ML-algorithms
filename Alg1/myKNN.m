function modes = myKNN(training_data,test_data,k)
[t1,n1]=size(training_data);
[t2,n2]=size(test_data);
train=training_data(:,1:n1-1);
test=test_data(:,1:n2-1);
d=zeros(t2,t1);
for i=1:t2
    for j=1:t1
        temp=sqrt(sum((test(i,:) - train(j,:)).^2)); 
        d(i,j)=sqrt(temp); 
    end
end
flag=0;modes=[];
for i=1:t2
    dis=d(i,:);
    [~,x] = sort(dis);
    ind = x(1:k);
    f=training_data(ind,n2);
    modes(i)=mode(f);
    if(modes(i) ~= test_data(i,n2))flag=flag+1;
    end
end
err1=(flag/t2)*100;sprintf('Error rate for k=%d is %0.5f',k,err1)