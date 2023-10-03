function [ U,C ] = old_model( ca,cd,n,Nc )
if(ca<1/n)
    temp=n/(2*(n-1));
    if(cd<=temp)
        C=1/n+cd*(1-1/n)^2;
        U=1/n-ca;
    else
        C=1-1/(4*cd);
        U=1-1/(2*cd)-ca;
    end
else
    temp=(1+sqrt(2*ca-ca^2))/(2*(1-ca)^2);
    if(cd<=temp)
        if(ca<Nc/n)
            C=ca+cd*(1-ca)^2;
            U=ca-ca/Nc;
        else
            C=cd*(1-ca)^2;
            U=0;
        end
    else
        C=1-1/(4*cd);
        U=1-1/(2*cd)-ca;
    end
end
end

