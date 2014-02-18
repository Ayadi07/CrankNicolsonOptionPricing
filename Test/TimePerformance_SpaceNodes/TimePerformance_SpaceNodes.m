function [  ] = TimePerformance_SpaceNodes( MaxSpaceNodes,MaxTimeNodes )
%TIMEPERFORMANCE_SPACENODES Summary of this function goes here
%   Detailed explanation goes here

    increment=10;
    
    S0=80;
    K=100;
    T=1;
    r=.06;
    volatility=.25;    
    time=MaxTimeNodes;
    
    i=1;
    tic;
        [C, P] = blsprice(S0, K, r, T, volatility, 0);
    bs=toc;
    for space=10:increment:MaxSpaceNodes
            tic;
                [Call,Put]=BSCranKNicolson(S0,K,T,r,volatility,space,time );
            performance(i)=toc;
            error(i)=abs(Call-C);
            i=i+1;
    end;
        
    figure
    hold on;
    space=1:1:i-1;
    
    plot(10*space,performance,'color','red');
    plot(10*space,error,'color','blue');
    plot(10*space,bs*ones(size(space)),'color','green');
    
    xlabel('space nodes ');
    legend('Time Crank-Nicolson','Error','Time blsprice()','location','Best');
    
    title(sprintf('Time Vs error=f(Space discretisation) \nTime nodes=%d\nS0=%.2f; K=%.2f; T=%.2f;\nr=%.2f; volatility=%.2f;'...
    ,time,S0,K,T,r,volatility),'FontSize',10,'color','red');

end