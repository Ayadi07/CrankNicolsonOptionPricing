function x=Forward(L,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithme de Forward                                           %
% D�claration d'une fonction pour calculer x, on donne la matrice  %
% A et la vecteur b en param�tres.                                 %
% Resolution de Lx=b avec L triangulaire inf�rieure                %
% b vecteur.                                                       %
% R�alis� par InfinI promo 3, ESPRIT le 24 sep 2012 � 9:54         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 n = length(b);
 x = zeros (n,1);
 x(1) = b(1) / L(1,1);
 
 for i = 2 : n
     
     som = 0;
     for j = 1 : i-1
         som = som + L(i,j) * x(j);
     end
     x(i) = (b(i) - som) / L(i,i);
 end