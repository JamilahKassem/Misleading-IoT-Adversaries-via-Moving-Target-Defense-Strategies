clear;
close all;
alpha =[
    0.4 , 0.3 , 0.3;
    0.2 , 0.3 , 0.5;
    0.4 , 0.4 , 0.2;
    ]';
alpha =[
    0.7 , 0.2 , 0.1;
    0.8 , 0.1 , 0.1;
    0.2 , 0.7 , 0.1;
    ]';
create=false;
Nc=size(alpha,2);
Pos =[
    1 , 3 , 2;
    ];
if create
    sums=zeros(2,Nc);
    Nn=size(alpha,1);
    for k=1:Nc
        for j=1:Nn
            sums(1,k)=sums(1,k)+alpha(k,j);
            sums(2,k)=sums(2,k)+alpha(j,k);
        end
    end
else
    cds=0.1:0.01:1;
    Cds_1=size(size(cds,1));
    Cds_2=size(size(cds,1));
    Cds_3=size(size(cds,1));
    C=1;
    ca=1/Nc;
    for cd=cds
        i=1;
        Cds_1(C)=1-1/(4*cd);
        Total=0;
        for k=1:Nc
            Total=Total+(1-alpha(Pos(k),k))^2;
        end
        Cds_2(C)=Total*cd/Nc;
        Total_Network=0;
        for k=1:Nc
            Total_Network=Total_Network+alpha(i,k);
        end
        Total_Network=Total_Network/Nc;
        Cds_3(C)=Total_Network+Cds_2(C);
        C=C+1;
    end
end
plot(cds,Cds_1);
hold on;
plot(cds,Cds_2);
plot(cds,Cds_3);
hold off;
xlabel('defence cost');
ylabel('defender cost');
legend('Optimum','No attack','with attack');
