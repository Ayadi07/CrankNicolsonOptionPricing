function x=Backward(U,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithme de Remontee                                           %                                 %
% Resolution de Ux=b avec U triangulaire superieure                %
% b vecteur.                                                       %
% Réalisé par InfinI promo 3, ESPRIT le 24 sep 2012 à 10:16         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 n = length(b);
 x = zeros (n,1);
 x(n) = b(n) / U(n,n);
 
 for i = (n-1) : -1 : 1
     
     som = 0;
     for j = i+1 : n
         som = som + U(i,j) * x(j);
     end
     x(i) = (b(i) - som) / U(i,i);
 end