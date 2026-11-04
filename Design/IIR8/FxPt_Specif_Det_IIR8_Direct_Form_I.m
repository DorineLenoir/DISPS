 %##########################################################################
%
%   DeterminationFormatIirCanonique.m : 
%
%   Fichier de détermination du format des données pour le filtre IIR 8 
%   non-cascadé basé sur la structre directe  
%
%   Entrées : 
%       - Num (1*9) : Numérateur du filtre d'ordre 8  
%       - Den (1*9) : Dénominateur du filtre d'ordre 8 
%       - My : position de la virgule de la sortie y(n) 
%       - Bmem : largeur des données en mémoire 
%       - Bmult : largeur des données en sortie du multiplieur 
%       - Badd : largeur des données pour l'additionneur  
%
%   Sortie :   
%       - data.format : format des différentes données 
%
%   Fonction : 
%       - Détermination du format des données pour préparer la simulation 
%
%##########################################################################

% Définition du format des données et des coefficients 

    % Coefficients 

Mb = 
Ma = 

    % Signaux 


Mz1 =
Mz2 = 

Madd = 


% Définiton du format des coefficients ---------------------------------------

b.B = Bmem;
b.M = Mb;
b.N = b.B-b.M;
b.format = sfrac(b.B,b.M);

a.B = Bmem;
a.M = Ma;
a.N = a.B-a.M;
a.format = sfrac(a.B,a.M);

% Détermination des coefficients en virgule fixe 



% Définition du format des variables input et output

x.B = Bmem;
x.M = Mx;
x.N = x.B-x.M;
x.format = sfrac(x.B,x.M);

y.B = Bmem;
y.M = My;
y.N = y.B - y.M;
s1.format=sfrac(y.B,y.M);


% Définition du format des variables intermédiaires

smb1.B = Bmult;          % Sortie de la multiplication x*b   
smb1.M = Mz1;
smb1.N = smb1.B-smb1.M;
smb1.format = sfrac(smb1.B,smb1.M);

sma1.B = Bmult;          % Sortie de la multiplication a*y   
sma1.M = Mz2;
sma1.N = sma1.B-sma1.M;
sma1.format=sfrac(sma1.B,sma1.M);


sadd1.B = Badd;
sadd1.M = Madd;
sadd1.N =sadd1.B-sadd1.M;
sadd1.format = sfrac(sadd1.B,sadd1.M);
