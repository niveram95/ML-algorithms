function [p1,p2,pc1,pc2]=Bayes_Learning(training_data,validation_data)
[v,si]=size(validation_data);[t,n]=size(training_data);
result1=zeros(1,n-1);result2=zeros(1,n-1);
for i=1:t
    c=training_data(i,n);
        if(c==1)
            result1=result1+training_data(i,1:n-1);
        else   result2=result2+training_data(i,1:n-1);
        end
end
pp1=result1/sum(training_data(:,n)==1);pp2=result2/sum(training_data(:,n)==2); 
check=40;
sigma=-5:5;result=zeros(1);
   for s=1:11 %Learning the priors and error rates for each sigma value given
       pc1=1/(1+exp(-sigma(s)));pc2=1-pc1;
       for i=1:v
           x=validation_data(i,1:n-1);
           p1=prod((pp1.^x).*((1-pp1).^(1-x)))*pc1;p2=prod((pp2.^x).*((1-pp2).^(1-x)))*pc2;
           if p1>p2
               result(i)=1;
           else result(i)=2;
           end
       end
       r=(result'==validation_data(:,si));error=(sum(r==0)/v)*100;
       sprintf('Sigma: %d,Error rate:%0.7f',sigma(s),error)
       if(error<check)
       sig=sigma(s);check=error;
       end
   end
   pc1=1/(1+exp(-sig));pc2=1-1/(1+exp(-sig));
       
           