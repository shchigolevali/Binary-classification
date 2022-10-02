function [answer]=parzen(x,y,x1,y1,x2,y2,h)

X1=[];
X2=[];

for i= 1:length(x1)
    if (distance(x1(i),y1(i),x,y)<= h)
        
        X1(1,i) = (Kernel(distance(x1(i),y1(i),x,y)))/h;
        
    end
end
X1(X1==0) =[];
for i= 1:length(x2)
    if (distance(x2(i),y2(i),x,y)<= h)
       X2(1,i) = (Kernel(distance(x2(i),y2(i),x,y)))/h;
    end
end

NewClass1= sum(X1);
NewClass2 = sum(X2);

if (NewClass1>NewClass2)
  answer = 1;
  'First class';
elseif (NewClass1<NewClass2)
  answer = 2;
  'Second class';
else
  answer = 3;
  'Error';
  
end

end