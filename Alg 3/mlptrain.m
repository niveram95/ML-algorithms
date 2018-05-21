
function [tr,val,z,w,v] = mlptrain(train_data,val_data,m,k)

td=load(train_data);
vd=load(val_data);
siz=size(td(:,1:end-1),1);
res=zeros(1,siz);
z=zeros(siz,m);
d=64;
for i=1:siz
    arr(i,td(i,end)+1)=1;
    res(i)=i;
end
mat=[ones(siz,1) td(:,1:end-1)];
diff=2;error=0.1;
v=-0.1+(0.1+0.1)*rand(k,m+1);
w=-0.1+(0.1+0.1)*rand(m,d+1);

while diff>1
    diff=-error;error=0;
    for i=1:siz
        c=randi([0,siz-i])+i;
        p=res(c);
        res(c)=res(i);
        res(i)=p;
    end
    for i=res
        temp1=(mat(i,:))*w';
        temp1(temp1<0)=0;
        temp=[1 temp1];
        z(i,:)=temp(2:end);       
        y=exp(temp*v')/sum(exp(temp*v'));
        error=error-(arr(i,:)*(log(y))');
        v=v+(10^-4*(((arr(i,:)-y))'*temp)); %Using equation 11.28
        w=w+(10^-4*((((arr(i,:)-y)*v(:,2:end)))'*mat(i,:)));%Using equation 11.29       
    end 
    diff=abs(error+diff);
end
[~,tr]=fnerr(td,w,v);[~,val]=fnerr(vd,w,v);
fprintf('Training error rate percentage for m = %d:\n%0.2f\n',m,tr*100);
fprintf('Validation error rate percentage for m = %d:\n%0.2f\n',m,val*100);
tr=tr*100;
val=val*100;
end
