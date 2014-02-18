function [ M ] = AnimateChangeStrike_SpaceNodes( TimeNodes )
%ANIMATECHANGESTRIKE Summary of this function goes here
%   Detailed explanation goes here

    S0=100;
    
    StrikeMin=40;
    increment=20;
    StrikeMax=200;
    r=.05;
    T=1;
    volatility=.2;   
    
    
    i=1;
    for K=StrikeMin:increment:StrikeMax
        [C, P] = blsprice(S0, K, r, T, volatility, 0);
        bsv(i)=C;
        i=i+1;
    end;
    xName = StrikeMin:increment:StrikeMax; 
    x=1:1:i-1;
    
    k=1;
    for space = 2:1:20       
        i=1;
        for K=StrikeMin:increment:StrikeMax
            [Call,Put]=BSCranKNicolson(S0,K,T,r,volatility,space,TimeNodes );
            bscv(i)=Call;
            i=i+1;
        end;    

        plot(bscv,'green');
        hold on;
        plot(bsv,'red');
        hold off;
        
        t=title(...
        sprintf('Crank-Nicolson-Call=f(K) VS blsprice varying space nodes\nS0=%.2f K=%.2f T=%.2f\nr=%.2f volatility=%.2f\ntime nodes=%d, space nodes=%d',...
        S0,K,T,r,volatility,TimeNodes,space),'FontSize',10,'color','red');
        get(t,'Position');
        set(t,'Position',get(t,'Position')+[0 -17 0]);
        
        legend('blsprice()', 'BSCranKNicolson()','location','Best');
        set(gca,'XTick',x); 
        set(gca,'XTickLabel',xName); 
        xlabel('Strike');
        ylabel('Price');
        M(k) = getframe;
        k=k+1;
    end
    movie(M,5)
end

