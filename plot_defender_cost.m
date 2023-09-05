clear;
close all;
% define number of nodes and networks
Nc=4;
n=3;

cds=0.25:0.01:1;
% initiate matrices for costs
Cds_1=zeros(size(cds,1));
Cds_2=zeros(size(cds,1));
Cds_3=zeros(size(cds,1));
% attack cost
ca=1/Nc;

cds_2_coefficient=(Nc-n*floor(ca))*(floor(ca)+1)*(1-ca/(floor(ca)+1))^2;
cds_3_coefficient=mod(Nc,n)*ceil(Nc/n)*(1-(floor(Nc/n)+mod(Nc,n)/n)/ceil(Nc/n))^2;

C=1;%counter coefficient
for cd=cds
    Cds_1(C)=(ceil(Nc/n))*(1-1/(4*cd));
    Cds_2(C)=cd*cds_2_coefficient;
    Cds_3(C)=Nc/n+cd*cds_3_coefficient;
    C=C+1;
end
figure;
Plot_Cds_1=plot(cds,Cds_1);
hold on;
Plot_Cds_2=plot(cds,Cds_2);
Plot_Cds_3=plot(cds,Cds_3);
hold off;
xlabel('defence cost cd');
ylabel('total defender cost');
legend('Optimum','No attack optimum','with attack optimum');
