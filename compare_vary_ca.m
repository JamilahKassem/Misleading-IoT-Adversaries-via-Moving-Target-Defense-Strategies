clear;
clc;
close all;
% define number of nodes and networks
Nc=1;
n=2;
% Nc=13;
% n=5;
% Nc=4;
% n=5;

% migration cost
cd=3/2;
% attack cost
ca=1/3;

%initiateset(gcf, 'PaperUnits', 'normalized') matrices for costs
cas=0.1:0.001:1;
Cost_old=zeros(size(cas,1));
Cost_old_modified=zeros(size(cas,1));
Cost_new=zeros(size(cas,1));
Utility_old=zeros(size(cas,1));
Utility_old_modified=zeros(size(cas,1));
Utility_new=zeros(size(cas,1));

C=1;%counter coefficient
Coef1 = mod(Nc,n)*ceil(Nc/n)*(1-(floor(Nc/n)+mod(Nc,n)/n)/ceil(Nc/n))^2;
Coef3 = 1 - Nc/(n * ceil(Nc/n));

for ca=cas
    delta = Coef3 - 1/(2*cd*mod(Nc,n)*ceil(Nc/n));
    Coef2 = (Nc-n*floor(ca))*ceil(ca)*(1-ca/ceil(ca))^2;
    t = (1 - ca/ceil(ca))^2;
    N = (Nc - n * floor(ca)) * ceil(ca);
    
    [ Utility_old(C),Cost_old(C) ] = old_model( ca,cd,n,Nc );
    [ Utility_old_modified(C),Cost_old_modified(C) ] = old_model_modified( ca,cd,n,Nc );
    Cost_old(C) = Nc*Cost_old(C);
    Utility_old(C) = Nc*Utility_old(C);
    Cost_old_modified(C) = Nc*Cost_old_modified(C);
    Utility_old_modified(C) = Nc*Utility_old_modified(C);
    [ Utility_new(C),Cost_new(C) ] = new_model( ca,cd,n,Nc,Coef1,Coef2,delta );
    C=C+1;
end

h=figure;
plot(cas,Cost_old,'-','color','red');
hold on;

temp=1-sqrt(4*cd-1)/(2*cd);
if temp>cas(1) && temp<cas(end)
    xline(temp,'-r','logic model');
end
if 1/n>temp
    if 1/n>cas(1) && 1/n<cas(end)
        xline(1/n,'-r','no attack');
    end
end
if Nc/n>temp
    if Nc/n>cas(1) && Nc/n<cas(end)
        xline(Nc/n,'--r','no attack');
    end
end

plot(cas,Cost_old_modified,'-+','color','red');
plot(cas,Cost_new,'--','color','red');
plot(cas,Utility_old,'-','color','blue');
plot(cas,Utility_old_modified,'-+','color','blue');
plot(cas,Utility_new,'--','color','blue');
hold off;
xlabel('attack cost ca');
ylabel('Gain');
legend('Original model cost App1','Original model cost App2','New model cost','Original model utility App 1','Original model utility App2','New model utility');
set(h,'papersize',[5.3 4.5]);
print(h,['compare_ca_Nc_',num2str(Nc),'_n_',num2str(n)],'-dpdf');