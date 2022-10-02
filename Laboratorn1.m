clc
close all
clear all

x1 = unidrnd(100,1,500);
y1 = unidrnd(50,1,500);
x2 = unidrnd(100,1,500);
y2 = unidrnd(49,1,500) + 51;


for i = 1:length(x1)
    for j = (i+1) : length(x1)
        if x1(i) == x1(j) && y1(i)==y1(j)
            x1(i)= [0];
            y1(i) = [0];
        end
    end
end
x1(x1==0) =[];
y1(y1==0) =[];

for i = 1:length(x2)
    for j = (i+1) : length(x2)
        if x2(i) == x2(j) && y2(i)==y2(j)
            x2(i)= [0];
            y2(i) = [0];
        end
    end
end
x2(x2==0) =[];
y2(y2==0) =[];

Firstclass  = [x1 y1];
Secondclass = [x2 y2];

allx = [x1,x2];
ally = [y1,y2];

TrainingX=[];
TestX=[];

TrainingY=[];
TestY=[];
R =[;];

for h = 1:1:30 
    for step = 1:10
        a = ceil(length(allx)*rand(1,length(allx)));
        c = unique(a);
        b=1:1:length(allx);
        t = setdiff(b,c);

        for i = 1:length(c)
            TrainingX(i)= allx(c(i));
            TrainingY(i)= ally(c(i));
        end

        for i = 1:length(t)
            TestX(i)= allx (t(i));
            TestY(i)= ally (t(i));
        end
        TrainingX1 =[]; TrainingX2 =[];TrainingY1 =[];TrainingY2 =[];
    
        for i = 1:length(TrainingX)
            if TrainingY(i)< 50
                TrainingX1(i) = TrainingX(i);
                TrainingY1(i) = TrainingY(i);
            else
                TrainingX2(i) = TrainingX(i);
                TrainingY2(i) = TrainingY(i);
            end
        end
        X1=[];Y1=[];X2=[];Y2=[]; 
        error =0;

        for i = 1:length(TestX)
            x = TestX(i);
            y = TestY(i);
            answer = parzen(x,y,TrainingX1,TrainingY1,TrainingX2,TrainingY2,h);
            if answer == 1
                X1(i)= x;
                Y1(i)= y;
                if Y1(i)>50
                    error = error +1;
                end
            end
            if answer == 2
                X2(i)= x;
                Y2(i)= y;
                if Y2(i)<=50
                    error = error +1;
                end
            end
        end
        
        R(step,h)= error/length(TestX); 
        error=0;
        
        TestX=[];TestY=[];
        TrainingX=[];TrainingY=[];
        TrainingX1=[];TrainingY1=[];TrainingX2=[];TrainingY2=[];
    end
end

R2 = std(R);
M2 = mean(R);

for i=1:length(R2)
    mstd=min(R2);
    mmean=min(M2);
    if (R2(i)==mstd) && (M2(i)==mmean)
        h=i
    elseif (R2(i)==mstd)
        h=i
    end
end 
 

p = [1:100];
g = [1:100];
[X,Y] = meshgrid(p,g);
result = [X(:) Y(:)];

A= result(1:10000);
B= result(10001:20000);

for i = 1:length(x1)
    for j = 1:length(A)
        if A(j) == x1(i) && B(j)==y1(i)
            A(j) = [0];
            B(j) = [0];
        end
    end
end
A(A==0) =[];
B(B==0) =[];

for i = 1:length(x2)
    for j = 1:length(A)
        if A(j) == x2(i) && B(j)==y2(i)
            A(j)= [0];
            B(j) = [0];
        end
    end
end
A(A==0) =[];
B(B==0) =[];

for i = 1:length(A)

    x = A(i);
    y = B(i);
    answer = parzen(x,y,x1,y1,x2,y2,h);
    if answer == 1
        FX1(i)= x;
        FY1(i)= y;
    end
    if answer == 2
        FX2(i)= x;
        FY2(i)= y;
    end
end

FX1(FX1==0) =[];
FY1(FY1==0) =[];
FX2(FX2==0) =[];
FY2(FY2==0) =[];

plot (x1,y1,'.r',x2,y2,'.m',FX1,FY1,'*y',FX2,FY2,'*g')
hold on
plot([0 100],[50 50],'-k');
