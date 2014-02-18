function [ M ] = AnimateChangeExpiry( SpaceNodes )
%ANIMATECHANGEMATURITY Summary of this function goes here
%   Detailed explanation goes here

    TMin=1;
    increment=1;
    TMax=20;
    S0=80;
    K=70;
    r=.06;
    volatility=.4;   
    
    space=SpaceNodes;
    k=1;
    for time = 10:100:810
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
        hold off;
            
        t=title(...
        sprintf('Crank-Nicolson-Call=f(T) VS blsprice\nS0=%.2f K=%.2f\nr=%.2f volatility=%.2f\n space nodes=%d time nodes=%d',...
        S0,K,r,volatility,SpaceNodes,time),'FontSize',10,'color','red');
        get(t,'Position');
        set(t,'Position',get(t,'Position')+[0 -14 0]);

        legend('blsprice()', 'BSCranKNicolson()','location','Best');

        xName = TMin:increment:TMax; 
        x=1:1:i-1;
        set(gca,'XTick',x); 
        set(gca,'XTickLabel',xName); 
        xlabel('Maturity T (years)');
        ylabel('Price');
        M(k) = getframe;
        k=k+1;
    end
    movie(M,5)
end

