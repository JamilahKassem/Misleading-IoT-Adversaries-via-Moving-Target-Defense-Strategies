function [ U,C ] = new_model( ca,cd,n,Nc,Coef1,coef2,delta )
if(ca<Nc/n)
    if(delta>0)
        C=Nc/n + delta + 1/(4*cd*mod(Nc,n)*ceil(Nc/n));
        U=Nc/n + delta - ca;
    else
        C=Nc/n+cd*Coef1;
        U=Nc/n-ca;
    end
else
    C1=cd*coef2;
    C2=Nc/n + delta + 1/(4*cd*mod(Nc,n)*ceil(Nc/n));
    if(C1<C2)
        C=C1;
        U=0;
    else
        C=C2;
        U=Nc/n + delta - ca;
    end
end
end

