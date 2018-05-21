train='optdigits_train.txt';
testdata='optdigits_test.txt';
valid='optdigits_valid.txt';
tr=[0 0 0 0 0 0];va=[0 0 0 0 0 0];
k=10;
i=1;figure;temp=[];
for m=3:3:18
   [tra,val,z,w,v]=mlptrain(train,valid,m,k);
   hold on;
   tr(m/3)=tra;
   va(m/3)=val;
    if m==18
        h=[3 6 9 12 15 18];
        plot(tr,h,'-o',...
            'MarkerEdgeColor','blue',...
            'LineWidth',2);hold on; 

        plot(va,h,'-o',...
            'MarkerEdgeColor','red',...
            'LineWidth',2);hold on;
        legend('Training error','Validation error')
    end
   if(m==15)
       ztest=mlptest(testdata,w,v);
   end
end
