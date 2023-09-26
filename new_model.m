function [ U,C ] = new_model( ca,cd,n,Nc,Coef1,coef2,math_limit )
if(ca<Nc/n)
    temp=n/(2*(n-1));
    if(cd<=temp)
        C=Nc/n+cd*Coef1;
        U=Nc/n-ca;
    else
        C=ceil(Nc/n)*(1+(mod(Nc,n)-2)/(4*cd));
        U=ceil(Nc/n)*(1-1/(2*cd)-ca);
    end
else
    if(cd<=math_limit)
        C=cd*coef2;
        U=0;
    else
        C=ceil(Nc/n)*(1+(mod(Nc,n)-2)/(4*cd));
        U=ceil(Nc/n)*(1-1/(2*cd)-ca);
    end
end
end

