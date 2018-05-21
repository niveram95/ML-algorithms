function z=mlptest(test,w,v)
te=load(test);
siz=size(te,1);
a=[ones(siz,1) te(:,1:end-1)];
%z=1./(1+exp(-a*w'));
z=a*w';
z(z<0)=0;
temp=[ones(siz,1) z]*v';
for t=1:size(te,1)
    b(t,:)=exp(temp(t,:))/sum(exp(temp(t,:)));
    [~,idx]=max(b(t,:));res(t,1)=idx-1;
end
err=sum(res~=te(:,end))/size(te,1);
disp('Error rate for test data with m chosen as 15 in %');disp(err*100);
end
