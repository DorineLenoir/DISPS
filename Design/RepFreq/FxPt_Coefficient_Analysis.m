%##########################################################################
%
%   FxPt_Coefficient_Analysis.m : 
%
%   Analysis of the coefficient quantization effects on the frequancy resposne 
%
%   Input: 
%       - NumCas (4*3): Cascaded filter Numerator  
%       - DenCas (4*3): Cascaded filter Denominator
%       - Num (1*9) : Non-cascaded filter Numerator 
%       - Den (1*9) : Non-cascaded filter Denominator
%
%   Fonction : 
%       - plot of the frequency responses for cascaded and non-cascaded 
%       - computation of the roots of the transfert functions 
%
%##########################################################################
 

L = 2^12; 

% Tested word-length for the coefficients 

figure 

TabBcoef = [10, 12, 16, 20];

for i = 1:length(TabBcoef)

    Bcoef  = TabBcoef(i);

% Fixed-point format for the coefficients 


Mb = integer_word_length( max( max( abs( NumCas))),1);

Ma = integer_word_length( max( max( abs( DenCas))),1);

 
b.B = Bcoef;
b.M = Mb;
b.N = b.B-b.M;


 
a.B = Bcoef;
a.M = Ma;
a.N = a.B-a.M;

% Fixed-point values for the coefficients   

NumFix1 = fx_pt_value(NumCas(1,:), b);
NumFix2 = fx_pt_value(NumCas(2,:), b);
NumFix3 = fx_pt_value(NumCas(3,:), b);
NumFix4 = fx_pt_value(NumCas(4,:), b);

DenFix1 = fx_pt_value(DenCas(1,:), a);
DenFix2 = fx_pt_value(DenCas(2,:), a);
DenFix3 = fx_pt_value(DenCas(3,:), a);
DenFix4 = fx_pt_value(DenCas(4,:), a);


% Transfer function with fixed-point coeffiicient  

H1 = tf(NumFix1,DenFix1 , Te, 'Variable','z^-1');   
H2 = tf(NumFix2,DenFix2 , Te,'Variable','z^-1');   
H3 = tf(NumFix3,DenFix3 , Te,'Variable','z^-1');   
H4 = tf(NumFix4,DenFix4 , Te,'Variable','z^-1'); 

Hd1 = tf(1,DenFix1 , Te,'Variable','z^-1');   
Hd2 = tf(1,DenFix2 , Te,'Variable','z^-1');   
Hd3 = tf(1,DenFix3 , Te,'Variable','z^-1');   
Hd4 = tf(1,DenFix4 , Te,'Variable','z^-1'); 




% Global transfer function in fixed-point  

H = H1 * H2 * H3 * H4;

[ NumFixCas , DenFixCas] = tfdata(H,'v');

% Module des poles du filtre cascad?

TabPolesCas(i,:) = abs(roots(DenFixCas))';


%--------------------------------------------------------------------------

% Fixed-point format for the non-cascaded form  


Mb_nc = integer_word_length(  max( abs( Num)),1);

Ma_nc = integer_word_length(  max( abs( Den)),1);

b_nc.B = Bcoef;
b_nc.M = Mb_nc;
b_nc.N = b_nc.B-b_nc.M;

a_nc.B = Bcoef;
a_nc.M = Ma_nc;
a_nc.N = a_nc.B-a_nc.M;

% Fixed-point value for the coefficients  

NumFix = fx_pt_value(Num, b_nc);

DenFix = fx_pt_value(Den, a_nc);


% Module des poles du filtre non-cascad?

TabPoles(i,:) = abs(roots(DenFix))';

%--------------------------------------------------------------------------

% plot of the frequency response  

NFp1  = round(L* Wp(1) );
NFp2  = round(L* Wp(2) );
NFs1  = round(L* Ws(1) );
NFs2  = round(L* Ws(2) );

gabh = [  -Rs * ones(NFs1,1);   0 * ones(NFs2-NFs1,1);   -Rs * ones(L-NFs2,1)];
gabl = [-1000 * ones(NFp1,1); -Rp * ones(NFp2-NFp1,1); -1000 * ones(L-NFp2,1)];

subplot(2,2,i)

  

[FreqResp,w] = freqz(NumFix,DenFix,L);        
[FreqRespCas,w] = freqz(NumFixCas,DenFixCas,L); 

hold on; 
plot( w(1:L-1)*Fe/(2*pi),20*log10( abs(FreqResp(1:L-1)) ), 'r--'); 
plot( w(1:L-1)*Fe/(2*pi),20*log10( abs(FreqRespCas(1:L-1)) )); 


title(strcat(strcat('Frequency response - coefficient word-length : ', num2str(Bcoef)),' bits')); 
axis([0 Fe/2 -60 5]); 
grid
hold on; 
plot(w*Fe/(2*pi),gabh,'k'); 
plot(w*Fe/(2*pi),gabl,'k');  
xlabel('Frequency (Hz)')
ylabel('Module (dB)')


end

% Affichage du module des poles 

disp('Pole Module cascaded filter')
disp(TabPolesCas)

disp('Pole Module non-cascaded filter')
disp(TabPoles)
