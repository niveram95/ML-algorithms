function [z,err]=fnerr(dat,w,v)
a=[ones(size(dat,1),1) dat(:,1:end-1)];
z=a*w';
z(z<0)=0;
temp=[ones(size(dat,1),1) z]*v';
for i=1:size(dat,1)
    b(i,:)=exp(temp(i,:))/sum(exp(temp(i,:)));
    [temp2,temp1]=max(b(i,:));res(i,1)=temp1-1;
end
err=sum(res~=dat(:,end))/size(dat,1);
end