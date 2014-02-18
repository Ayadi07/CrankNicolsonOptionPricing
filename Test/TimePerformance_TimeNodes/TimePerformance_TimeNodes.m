function [  ] = TimePerformance_TimeNodes( MaxSpaceNodes,MaxTimeNodes )
%TIMEPERFORMANCE_TIMENODES Summary of this function goes here
%   Detailed explanation goes here
   
    increment=10;
    
    S0=100;
    K=120;
    T=1;
    r=.05;
    volatility=.2;    
    space=MaxSpaceNodes;
    
    i=1;
    tic;
        [C, P] = blsprice(S0, K, r, T, volatility, 0);
    bs=toc;
    for time=10:increment:MaxTimeNodes
            tic;
                [Call,Put]=BSCranKNicolson(S0,K,T,r,volatility,space,time );
            performance(i)=toc;
            error(i)=abs(Call-C);
            i=i+1;
    end;
        
    figure
    close all;
    hold on;
    time=1:1:i-1;
    
    plot(10*time,performance,'color','red');
    plot(10*time,error,'color','blue');
    plot(10*time,bs*ones(size(time)),'color','green');
    hold off
    xlabel('time nodes ');
    legend('Time Crank-Nicolson','Error','Time blsprice()','location','Best');
    
    title(sprintf('Time Vs error=f(time nodes) \nSpace nodes=%d\nS0=%.2f; K=%.2f; T=%.2f; r=%.2f; volatility=%.2f;'...
    ,space,S0,K,T,r,volatility),'FontSize',10,'color','red');
    
end

