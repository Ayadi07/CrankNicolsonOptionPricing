function [ ] = ChangeStrike( SpaceNodes,TimeNodes )
%CHANGESTRIKE Summary of this function goes here
%   Detailed explanation goes here

close all;

    StrikeMin=80;
    increment=10;
    StrikeMax=300;
    
    S0=100;    
    T=1;
    r=.05;
    volatility=.2;    
    time=TimeNodes;   
    space=SpaceNodes;
    
    i=1;
    for K=StrikeMin:increment:StrikeMax
            [Call,Put]=BSCranKNicolson(S0,K,T,r,volatility,space,time );
            bscv(i)=Call;
            [C, P] = blsprice(S0, K, r, T, volatility, 0);
            bsv(i)=C;
            i=i+1;
    end;    
    
    xName = StrikeMin:increment:StrikeMax; 
    x=1:1:i-1;
    
    plot(x,bsv, 'g',x,bscv, 'r-.', 'linewidth', .5);
    
    t=title(sprintf...
    ('Crank Nicolson Call(K) price compared to Matlab\nS0=%.2f K=%.2f T=%.2f\nr=%.2f volatility=%.2f\n time nodes=%.2f, space nodes=%.2f',...
    S0,K,T,r,volatility,TimeNodes,SpaceNodes),'FontSize',14,'color','red');
    get(t,'Position');
    set(t,'Position',get(t,'Position')+[0 -7 0]);
    
    legend('blsprice()', 'BSCranKNicolson()', 'location','best');
    
    set(gca,'XTick',x); 
    set(gca,'XTickLabel',xName); 
    xlabel('Strike');
    ylabel('Price');
    
end