function [Call,Put] = BSCranKNicolson( S0,K,T,r,volatility,N,M )
%BSCranKNicolson Summary of this function goes here
%   Detailed explanation goes here
    v=volatility;
    v2=power(v,2);
    
    maturity=T;             %for further call put parity formula
    
    T=v2*T./2;              %change of variable tau=((T-t)volatility^2)/2;
    %time points nbr
    NbrPtTime=M-1;
    dt=T./(NbrPtTime);    %example [pt1]__[pt2]__[pt3]; dt=0.5
    %time points nbr
    
    %spot points nbr
    x0=log(S0/K);           %change of variable x=Ln(S/K);
    NbrPtSpot=N-1;
    Xmax=max(x0,0)+log(4);
    Xmin=min(x0,0)-log(4);    
    dx=(Xmax-Xmin)/(NbrPtSpot);
    %spot points nbr

    c= dt./power(dx,2);
    m=2*r./v2;
	
        %space domain discretisation
    X=[x0:dx:Xmax];         %It is important for the presicion and 
                            %the price retrieval, to insure that x0 value
                            %exists in the vector
    X=X(end:-1:1);
    n0=length(X); %X0 index
    X=[X,[x0-dx:-dx:Xmin]]';              %[inf....x0....inf]

    %space domain discretisation


    %initial time boundary condition
    for j=1:NbrPtSpot
        COld(j)=max(exp(0.5*(m+1)*X(j))-exp(0.5*(m-1)*X(j)),0);
    end;
    %initial time boundary condition


    %A
    c2=c./2;
    A=(c+1)*eye(NbrPtSpot);
    for i=2:(NbrPtSpot)
        A(i,(i-1))=-c2;
        A((i-1),i)=-c2;        
    end;
    %end A

    %constant coefficients
    %low = chol(A,'lower');
    low=cholesky(A);%evaluated once : cholesky() is faster than chol
    %constant coefficients
    
	mm1=m-1;
	mp1=m+1;
	
    to=0;
    for n=1:NbrPtTime
        
        for i=2:NbrPtSpot-1
            b(i)=(1-c)*COld(i)+c2*(COld(i+1)+COld(i-1));
        end;
        
        x2=X(1)/2;
        to4=to/4;
        %space boundaries
        b(NbrPtSpot)=0;
        b(1)=exp((mp1)*x2+(mp1)^2*to4)-exp((mm1)*x2+(mm1)^2*to4);
        %space boundaries
        
        %Solve the linear system every dt
        COld=SolveLLt(low,b);
        %Solve the linear system every dt
        
        to=to+dt;
        
    end;
    %retrieve the price
    alpha=-(mm1)./2;
    beta=-power(mp1,2)./4;
    Call=K*exp(alpha*x0+beta*T)*COld(n0);
    Put=Call-S0+K*exp(-r*maturity);
end

