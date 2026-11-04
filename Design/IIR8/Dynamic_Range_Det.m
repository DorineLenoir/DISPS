%##########################################################################
%
%   DeterminationDynamique.m : 
%
%   Fichier de détermination de la dynamique des données du filtre non-cascadé   
%
%   Entrées : 
%       - Num (1*9) : Numérateur du filtre d'ordre 8  
%       - Den (1*9) : Dénominateur du filtre d'ordre 8 
%
%   Sortie :   
%       - My : position de la virgule de la sortie y(n) 
%       - Md : position de la virgule de la variable w(n) 
%
%   Fonction : 
%       - Calcul de la dynamique des données y(n) et w(n) 
%
%##########################################################################

% Definition des fonctions de transfert  

   Hn = tf(Num,1 , Te, 'Variable','z^-1');   % Hn(z) = Y(z)/D(z)
   Hd = tf(1 ,Den, Te, 'Variable','z^-1');   % Hd(z) = D(z)/X(z)
   H = Hd * Hn;                         % H(z)  = Y(z)/X(z)
  
% Determination de la dynamique des des données 

   N_norm = 2048;

  Dyn_y_L1    = dynamic_norm_L1(   H_y, N_norm,Dyn_x); 
  Dyn_y_Cheby = dynamic_norm_Cheby(H_y, N_norm, Dyn_x); 
  M_y_L1      = integer_word_length(Dyn_y_L1,1);
  M_y_Cheby   = integer_word_length(Dyn_y_Cheby,1);
  print_Dyn('y',Dyn_y_L1,M_y_L1,Dyn_y_Cheby,M_y_Cheby); 

  My = M_y_Cheby; 
  
   
 
  
