%##########################################################################
%
%   AnalyseFiltre.m : 
%
%   Fichier d'analyse des réponses impulsionnelle et fréquentielle et des 
%   poles et zéros du filtre  
%
%   Entrées : 
%       - Num (1*9) : Numérateur du filtre non-cascadé 
%       - Den (1*9) : Dénominateur du filtre non-cascadé 
%
%   Sortie :   
%
%   Fonction : 
%       - Affichage de la réponse impulsionnelle  
%       - Affichage de la réponse fréquentielle (module, phase)
%       - Affichage des poles et des zéros du filtre 
%
%##########################################################################

close all;  %Ferme les figures en cours

% 1 Analyse du filtre numérique passe-bande du huitième ordre

Npts = 128; 
n=0 : Npts-1;

delta = [1; zeros(Npts-1,1)];  % Impulsion
step = ones(Npts,1);           % Echelon unité

    % Réponse impulsionnelle

h = filter(Num, Den, delta);    % Réponse du filtre (ou impz(b,a);)
figure; 
stem(n,h);

    % Réponse fréquentielle
    
figure
L = 2^12;
[h,w] = freqz(Num,Den,L);       % Retourne le resultat de l'analyse frequentielle sur L points entre 0 et pi
m = abs(h); 
p = angle(h);

subplot(2,2,1); 
plot( w(1:L-1),20*log10(m(1:L-1)) ); 
title('Log Magnitude for 8th order IIR Filtres'); 
axis([0 pi -60 2]); 
grid

subplot(2,2,2);
plot(w,m); 
title('Magnitude'); 

subplot(2,2,3);
plot(w,p); 
title('Phase');

subplot(2,2,4);
zplane(Num,Den);

Zeros = roots(Num);
Poles = roots(Den);

 



NFp1  = round(L* Wp(1) );
NFp2  = round(L* Wp(2) );
NFs1  = round(L* Ws(1) );
NFs2  = round(L* Ws(2) );

gabh = [  -Rs * ones(NFs1,1);   0 * ones(NFs2-NFs1,1);   -Rs * ones(L-NFs2,1)];
gabl = [-1000 * ones(NFp1,1); -Rp * ones(NFp2-NFp1,1); -1000 * ones(L-NFp2,1)];

figure 
plot( w(1:L-1),20*log10(m(1:L-1)) ); 
title('Log Magnitude Filtre RII 8eme ordre'); 
axis([0 pi -60 2]); 
grid
hold on; 
plot(w,gabh,'r'); 
plot(w,gabl,'r');  
