%##########################################################################
%
%   DeterminationFormatIirTranspose.m : 
%
%   Fichier de d?termination du format des donn?es pour le filtre IIR 8 
%   cascad? bas? sur la structre directe transpose  
%
%   Entr?es : 
%       - NumCas (4*3) : Num?rateurs des filtres cascad?s 
%       - DenCas (4*3) : D?nominateurs des filtres cascad?s 
%       - My : position de la virgule de la sortie y(n) 
%       - Mz : position de la virgule des entr?es des ADD  
%       - Bmem : largeur des donn?es en m?moire 
%       - Bmult : largeur des donn?es en sortie du multiplieur 
%       - Badd : largeur des donn?es pour l'additionneur  
%
%   Sortie :   
%       - data.format : format des diff?rentes donn?es 
%
%   Fonction : 
%       - D?termination du format des donn?es pour pr?parer la simulation 
%
%##########################################################################

disp(strcat(sprintf('\n D?termination du format des donn?es pour le filtre IIR 8 cascad? bas? sur la structre canonique \n')));

% D?finition du format des donn?es et des coefficients 

    % Coefficients 



Mb =

Ma =

    % Signaux 

Mz1 =
Mz2 =

Madd =  


% D?finiton du format des coefficients ---------------------------------------

b.B = Bmem;
b.M = Mb;
b.N = b.B-b.M;
b.format = sfrac(b.B,b.M);

a.B = Bmem;
a.M = Ma;
a.N = a.B-a.M;
a.format = sfrac(a.B,a.M);

% D?termination des coefficients en virgule fixe 


% D?termination des coefficients en virgule fixe 

NumFix1 = FixCode(NumCas(1,:), b.N);
NumFix2 = FixCode(NumCas(2,:), b.N);
NumFix3 = FixCode(NumCas(3,:), b.N);
NumFix4 = FixCode(NumCas(4,:), b.N);

DenFix1 = FixCode(DenCas(1,:), a.N);
DenFix2 = FixCode(DenCas(2,:), a.N);
DenFix3 = FixCode(DenCas(3,:), a.N);
DenFix4 = FixCode(DenCas(4,:), a.N);



% D?finition du format des variables 

x.B = Bmem;
x.M = Mx;
x.N = x.B-x.M;
x.format = sfrac(x.B,x.M);

y.B = Bmem;
y.M = My;
y.N = y.B - y.M;
s1.format=sfrac(y.B,y.M);


% D?finition du format des variables interm?diaires

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

saddMem.B = Bmem;
saddMem.M = Madd;
saddMem.N =saddMem.B-saddMem.M;
saddMem.format = sfrac(saddMem.B,saddMem.M);



AfficheFormat('   Format de b : ', b);
AfficheFormat('   Format de a : ', a);

AfficheFormat('   Format de x : ', x);
AfficheFormat('   Format de y : ', y);
AfficheFormat('   Format de w : ', d);

AfficheFormat('   Format de MULT (x*b) : ', smb1);
AfficheFormat('   Format de MULT2 (a*y) : ', sma1);

AfficheFormat('   Format de ADD  : ', sadd1);
AfficheFormat('   Format de MEM  : ', saddMem);

