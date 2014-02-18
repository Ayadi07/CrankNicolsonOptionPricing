function [  ] = ChangeExpiracy( SpaceNodes,TimeNodes )
%CHANGEMATURITY Summary of this function goes here
%   Detailed explanation goes here
close all;

    TMin=1;
    increment=1;
    TMax=20;
    S0=40;
    K=60;
    r=.05;
    volatility=.2;    
    time=TimeNodes;   
    space=SpaceNodes;
    
    i=1;
    for T=TMin:increment:TMax
            [Call,Put]=BSCranKNicolson(S0,K,T,r,volatility,space,time );
            bscv(i)=Call;
            [C, P] = blsprice(S0, K, r, T, volatility, 0);
            bsv(i)=C;
            i=i+1;
    end;    

    plot(bsv,'red');
    hold on
    plot(bscv,'green');    
    
    t=title(...
    sprintf('Crank Nicolson Call(T) price compared to Matlab\nS0=%.2f K=%.2f\nr=%.2f volatility=%.2f\n time nodes=%.2f, space nodes=%.2f',...
    S0,K,r,volatility,TimeNodes,SpaceNodes)...
    ,'FontSize',10,'color','red');
    get(t,'Position');
    set(t,'Position',get(t,'Position')+[0 -16 0]);
    
    legend('blsprice()', 'BSCranKNicolson()','location','Best');
    
    xName = TMin:increment:TMax; 
    x=1:1:i-1;
    set(gca,'XTick',x); 
    set(gca,'XTickLabel',xName); 
    xlabel('Maturity T (years)');
    ylabel('Price');
    

end

