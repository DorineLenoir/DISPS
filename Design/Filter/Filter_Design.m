%##########################################################################
%
%   ConceptionFiltre.m : 
%
%   Fichier de calcul des coefficients du filtre 
%
%   Entr?es : 
%
%   Sortie :   
%       - NumCas (4*3) : Num?rateurs des filtres cascad?s 
%       - DenCas (4*3) : D?nominateurs des filtres cascad?s 
%       - Num (1*9) : Num?rateur du filtre non-cascad? 
%       - Den (1*9) : D?nominateur du filtre non-cascad? 
%
%   Fonction : 
%       - Calcul des coefficients du filtre 
%       - Calcul des coefficients du filtre cascad? 
%
%##########################################################################

    Fe = 12000;                  % Frequence d'echantillonnage
    Te = 1/Fe;
    % Sp?cification du filtre  

    
    Fp1 = 1200;                 % Fr?quence basse de la bande passante 
    Fp2 = 2400;                 % Fr?quence haute de la bande passante 
 
    Fs1 = 1080;                 % Fr?quence basse de la bande att?nu?e 
    Fs2 = 2520;                 % Fr?quence haute de la bande att?nu?e 
   
    
    Wp = [2*Fp1/Fe 2*Fp2/Fe];   % Fr?quences hautes et basses de la bande passante 
    Ws = [2*Fs1/Fe 2*Fs2/Fe];   % Fr?quences hautes et basses de la bande att?nu?e 
 
    Rp = 3;                     % Att?nuation dans la bande passante 
    Rs = 30;                    % Att?nuation dans la bande att?nu?e 
     
    
    % Calcul de l'ordre du filtre
    
    [Nf, Wn] = buttord(Wp, Ws, Rp, Rs);      % Butterworth 
     disp(strcat(sprintf('\n Ordre du filtre - Butterworth : '), num2str(2 * Nf) ));

    [Nf, Wn] = cheb1ord(Wp, Ws, Rp, Rs);     % Chebyshev type I
     disp(strcat(sprintf('\n Ordre du filtre - Chebyshev type I : '), num2str(2 * Nf) ));   
    
    [Nf, Wn] = cheb2ord(Wp, Ws, Rp, Rs);    % Chebyshev type II
     disp(strcat(sprintf('\n Ordre du filtre - Chebyshev type II : '), num2str(2 * Nf) ));   
    
    [Nf, Wn] = ellipord(Wp, Ws, Rp, Rs);    % Elliptique 
     disp(strcat(sprintf('\n Ordre du filtre - Elliptique : '), num2str(2 * Nf) ));   

     
    % Calcul des coefficients du filtre - choisir le filtre d'ordre
    % minimal  
    
    [Num,Den] = ellip(Nf, Rp, Rs, Wn);
    
    % Calcul des coefficients du filtre cascad? 
    
    [KCas,NumCas1,DenCas1] = dir2cas(Num,Den);
   
    % Int?gration du coefficent de normalisation au sein des cellules 
    
    NumCas1 = ( KCas^0.25  ) .* NumCas1;
    
     if Permutation ==1
     
        NumCas(1,:) = NumCas1(3,:);
        NumCas(2,:) = NumCas1(2,:);
        NumCas(3,:) = NumCas1(4,:);
        NumCas(4,:) = NumCas1(1,:);
  
        DenCas(1,:) = DenCas1(3,:);
        DenCas(2,:) = DenCas1(2,:);
        DenCas(3,:) = DenCas1(4,:);
        DenCas(4,:) = DenCas1(1,:);
     
     else
     
          NumCas = NumCas1;
          DenCas = DenCas1;
     end
     
    
 
     