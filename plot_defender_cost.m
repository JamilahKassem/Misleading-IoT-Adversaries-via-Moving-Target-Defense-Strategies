clear;
close all;
alpha =[
    1/3 , 0.7/3 , 1.3/3;
    0.2 , 0.3 , 0.5;
    0.5 , 0.3 , 0.2;
    0.3 , 0.5 , 0.2;
    ]';
create=false;
Nc=size(alpha,2);
n=size(alpha,1);
if create
    sums1=zeros(1,n);
    sums2=zeros(1,Nc);
    n=size(alpha,1);
    for k=1:Nc
        for j=1:n
            sums1(1,j)=sums1(1,j)+alpha(j,k);
            sums2(1,k)=sums2(1,k)+alpha(j,k);
        end
    end
    return;
else
    cds=0.25:0.01:1;
    Cds_1=zeros(size(cds,1));
    Cds_2=zeros(size(cds,1));
    Cds_3=zeros(size(cds,1));
    C=1;
    ca=1/Nc;
    
    Pos=zeros(1,Nc);
    
    Total_Network=0;
    for i=1:n
        Temp=0;
        for k=1:Nc
            Temp=Temp+alpha(i,k);
        end
        if(Temp>Total_Network)
            Total_Network=Temp;
        end
    end
    Total=0;
    for k=1:Nc
        TempMaxalpha=0;
        for i=1:n
            if(alpha(i,k)>TempMaxalpha)
                TempMaxalpha=alpha(i,k);
                Pos(k)=i;
            end
        end
        Total=Total+(1-alpha(Pos(k),k))^2;
    end
    cds_2_coefficient=(Nc-n*floor(ca))*(floor(ca)+1)*(1-ca/(floor(ca)+1))^2;
    cds_3_coefficient=mod(Nc,n)*ceil(Nc/n)*(1-(floor(Nc/n)+mod(Nc,n)/n)/ceil(Nc/n))^2;
    for cd=cds
        Cds_1(C)=Nc-Nc/(4*cd);
        Cds_2(C)=cd*cds_2_coefficient;
        Cds_3(C)=Nc/n+cd*cds_3_coefficient;
        C=C+1;
    end
end
figure;
% ax_plot = axes('position',[.11 .22 0.8 .75]);
plot(cds,Cds_1);
hold on;
plot(cds,Cds_2);
plot(cds,Cds_3);
hold off;
xlabel('defence cost');
ylabel('defender cost');
legend('Optimum','No attack optimum','with attack optimum');
% max = 40;
% Count_sider = uicontrol('style','slider','Value',Nc,'Position',[290,10,200,20], 'Max',max, 'Min',1,'SliderStep', [1/(max-1), 1/(max-1)]);
% set_number = @(~,e)changeNumberSlider(e,Number_text,cds,Plot_Cds_3,Plot_Cds_4);
% addlistener(Count_sider, 'Value', 'PostSet',set_number);
