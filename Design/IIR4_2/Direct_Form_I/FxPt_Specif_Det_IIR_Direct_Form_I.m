%##########################################################################
%
%   FxPt_Specif_Det_IIR_Direct_Form_I.m : 
%
%   Determination of the fixed-point format for Direct Form I - cascaded
%   biquad
%
%   Input: 
%       - NumCas (4*3): Cascaded filter Numerator  
%       - DenCas (4*3): Cascaded filter Denominator
%       - My : Binary-point position for the output y(n) of a generic cell
%       - Bmem : Data word-length in memory
%       - Bmult : Output multiplier word-length 
%       - Badd : Input and output adder word-length
%
%   Sortie :   
%       - data.format : Fixed-point format of the different dats 
%
%   Fonction : 
%       - Fixed-point format determination for the simulation 
%
%##########################################################################

disp(strcat(sprintf('\n Determination of the fixed-point format for Direct Form I \n')));


% Fixed-point format determination 

    % Coefficients 

disp('Fill the code')

Mb =

Ma =

    % Data 
 

Mz1 =
Mz2 =

Madd =  


% Fixed-point format for Simulink simulation ---------------------------------------
    
    % Coefficients
    
b.B = Bmem;
b.M = Mb;
b.N = b.B-b.M;
b.format = sfrac(b.B,b.M);
print_FxPt_Format('   Coefficient b FxPt format: ', b);

a.B = Bmem;
a.M = Ma;
a.N = a.B-a.M;
a.format = sfrac(a.B,a.M);
print_FxPt_Format('   Coefficient a FxPt format: ', a);

        % Coefficent Fixed-Point values  

NumFix1 = fx_pt_value(NumCas(1,:), b);
NumFix2 = fx_pt_value(NumCas(2,:), b);
NumFix3 = fx_pt_value(NumCas(3,:), b);
NumFix4 = fx_pt_value(NumCas(4,:), b);

DenFix1 = fx_pt_value(DenCas(1,:), a);
DenFix2 = fx_pt_value(DenCas(2,:), a);
DenFix3 = fx_pt_value(DenCas(3,:), a);
DenFix4 = fx_pt_value(DenCas(4,:), a);


    % Data


x.B = Bmem;
x.M = Mx;
x.N = x.B-x.M;
x.format = sfrac(x.B,x.M);
print_FxPt_Format('   Variable x FxPt format: ', x);

y.B = Bmem;
y.M = My;
y.N = y.B - y.M;
s1.format=sfrac(y.B,y.M);
print_FxPt_Format('   Variable y FxPt format: ', y);

% Intermediate variables 

smb1.B = Bmult;          % Multiplication output: x*b   
smb1.M = Mz1;
smb1.N = smb1.B-smb1.M;
smb1.format = sfrac(smb1.B,smb1.M);
print_FxPt_Format('   Variable MULT1 (x*b) FxPt format: ', smb1);

sma1.B = Bmult;          % Multiplication output: a*y   
sma1.M = Mz2;
sma1.N = sma1.B-sma1.M;
sma1.format=sfrac(sma1.B,sma1.M);
print_FxPt_Format('   Variable MULT2 (y*a) FxPt format: ', sma1);

sadd1.B = Badd;
sadd1.M = Madd;
sadd1.N =sadd1.B-sadd1.M;
sadd1.format = sfrac(sadd1.B,sadd1.M);
print_FxPt_Format('   Variable ADD FxPt format: ', sadd1);


In.B = 1000;
In.M = Mx;
In.N = In.B-In.M;
In.format = sfrac(In.B,In.M);
%print_FxPt_Format('   Format de x : ', x);
