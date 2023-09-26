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

cas=0.1:0.01:1;
Cost_old=zeros(size(cas,1));
Cost_old_modified=zeros(size(cas,1));
Cost_new=zeros(size(cas,1));
Utility_old=zeros(size(cas,1));
Utility_old_modified=zeros(size(cas,1));
Utility_new=zeros(size(cas,1));

C=1;%counter coefficient
Coef1 = mod(Nc,n)*ceil(Nc/n)*(1-(floor(Nc/n)+mod(Nc,n)/n)/ceil(Nc/n))^2;

for ca=cas
    Coef2 = (Nc-n*floor(ca))*ceil(ca)*(1-ca/ceil(ca))^2;
    t = (1 - ca/ceil(ca))^2;
    N = (Nc - n * floor(ca)) * ceil(ca);
    math_limit_nume = 1 + sqrt(1 - N * t);
    math_limit_denume = abs(2 * N * t); 
    math_limit = math_limit_nume / math_limit_denume;
    
    [ Utility_old(C),Cost_old(C) ] = old_model( ca,cd,n,Nc );
    [ Utility_old_modified(C),Cost_old_modified(C) ] = old_model_modified( ca,cd,n,Nc );
    Cost_old(C) = Nc*Cost_old(C);
    Utility_old(C) = Nc*Utility_old(C);
    Cost_old_modified(C) = Nc*Cost_old_modified(C);
    Utility_old_modified(C) = Nc*Utility_old_modified(C);
    [ Utility_new(C),Cost_new(C) ] = new_model( ca,cd,n,Nc,Coef1,Coef2,math_limit );
    C=C+1;
end
h=figure;
plot(cas,Cost_old,'-','color','red');
hold on;
plot(cas,Cost_old_modified,'-+','color','red');
plot(cas,Cost_new,'--','color','red');
plot(cas,Utility_old,'-','color','blue');
plot(cas,Utility_old_modified,'-+','color','blue');
plot(cas,Utility_new,'--','color','blue');
hold off;
xlabel('attack cost ca');
ylabel('Gain');
legend('Original model cost','Modified model cost','New model cost','Original model utility','Modified model utility','New model utility');