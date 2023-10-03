clear;
clc;
close all;
% define number of nodes and networks
% Nc=1;
% n=2;
% Nc=13;
% n=5;
Nc=4;
n=5;

% migration cost
cd=3/2;
% attack cost
ca=1/3;

%initiate matrices for costs
cds=0.1:0.01:10;
Cost_old=zeros(size(cds,1));
Cost_old_modified=zeros(size(cds,1));
Cost_new=zeros(size(cds,1));
Utility_old=zeros(size(cds,1));
Utility_old_modified=zeros(size(cds,1));
Utility_new=zeros(size(cds,1));

C=1;%counter coefficient

Coef1 = mod(Nc,n)*ceil(Nc/n)*(1-(floor(Nc/n)+mod(Nc,n)/n)/ceil(Nc/n))^2;
Coef2 = (Nc-n*floor(ca))*ceil(ca)*(1-ca/ceil(ca))^2;
t = (1 - ca/ceil(ca))^2;
N = (Nc - n * floor(ca)) * ceil(ca);
Coef3 = 1 - Nc/(n * ceil(Nc/n));

for cd=cds
    delta = Coef3 - 1/(2*cd*mod(Nc,n)*ceil(Nc/n));
    [ Utility_old(C),Cost_old(C) ] = old_model( ca,cd,n,Nc );
    Cost_old(C) = Nc*Cost_old(C);
    Utility_old(C) = Nc*Utility_old(C);
    
    [ Utility_old_modified(C),Cost_old_modified(C) ] = old_model_modified( ca,cd,n,Nc );
    Cost_old_modified(C) = Nc*Cost_old_modified(C);
    Utility_old_modified(C) = Nc*Utility_old_modified(C);
    
    [ Utility_new(C),Cost_new(C) ] = new_model( ca,cd,n,Nc,Coef1,Coef2,delta );
    C=C+1;
end
h=figure;
plot(cds,Cost_old,'-','color','red');
hold on;

temp=(1+sqrt(2*ca-ca^2))/(2*(1-ca)^2);
if temp>cds(1) && temp<cds(end)
    xline(temp,'-r','logic model');
end

plot(cds,Cost_old_modified,'-+','color','red');
plot(cds,Cost_new,'--','color','red');
plot(cds,Utility_old,'-','color','blue');
plot(cds,Utility_old_modified,'-+','color','blue');
plot(cds,Utility_new,'--','color','blue');
hold off;
xlabel('migration cose cd');
ylabel('Gain');
legend('Original model cost App1','Original model cost App2','New model cost','Original model utility App 1','Original model utility App2','New model utility');
set(h,'papersize',[5.3 4.5]);
print(h,['compare_cd_Nc_',num2str(Nc),'_n_',num2str(n)],'-dpdf');