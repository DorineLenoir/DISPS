%##########################################################################
%
%   FxPt_Specif_Det_IIR_Direct_Form_II.m : 
%
%   Determination of the fixed-point format for Direct Form II - cascaded
%   biquad
%
%   Input: 
%       - NumCas (4*3): Cascaded filter Numerator  
%       - DenCas (4*3): Cascaded filter Denominator
%       - My : Binary-point position for the output y(n) of a generic cell
%       - Mw : Binary-point position for the variable w(n) of a generic cell
%       - Bmem : Data word-length in memory
%       - Bmult : Output multiplier word-length 
%       - Badd : Input and output adder word-length
%
%   Output :   
%       - data.format : Fixed-point format of the different dats 
%
%   Function : 
%       - Fixed-point format determination for the simulation 
%
%##########################################################################


disp(strcat(sprintf('\n Determination of the fixed-point format for Direct Form II - cascaded biquad \n')));

% Fixed-point format determination 

disp('Fill the code')

    % Coefficients 
  
Mb =

Ma =


    % Data 

    % Multiplication output: w*a

Mz1 =

Madd1 =

    % Multiplication output: w*b

Mz2 =

Madd2 =


% Fixed-point format for Simulink simulation ---------------------------------------
    
    % Coefficients

b.B = Bmem;
b.M = Mb;
b.N = b.B-b.M;
b.format = sfrac(b.B,b.M);

a.B = Bmem;
a.M = Ma;
a.N = a.B-a.M;
a.format = sfrac(a.B,a.M);

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

 
y.B = Bmem;
y.M = My;
y.N = y.B - y.M;
y.format=sfrac(y.B,y.M);

 
d.B = Bmem;
d.M = Mw;
d.N = d.B - d.M;
d.format=sfrac(d.B,d.M);


% Intermediate variables 

smb1.B = Bmult;          % Multiplication output: w*b   
smb1.M = Mz2;
smb1.N = smb1.B-smb1.M;
smb1.format = sfrac(smb1.B,smb1.M);

 
sma1.B = Bmult;          % Multiplication output: a*w   
sma1.M = Mz1;
sma1.N = sma1.B-sma1.M;
sma1.format=sfrac(sma1.B,sma1.M);

sadd1.B = Badd;         % Adder 1 :
sadd1.M = Madd1;
sadd1.N =sadd1.B-sadd1.M;
sadd1.format = sfrac(sadd1.B,sadd1.M);

sadd2.B = Badd;         % Adder 2
sadd2.M = Madd2;
sadd2.N =sadd2.B-sadd2.M;
sadd2.format = sfrac(sadd2.B,sadd2.M);



print_FxPt_Format('   Coefficient b FxPt format: ', b);
print_FxPt_Format('   Coefficient a FxPt format: ', a);

print_FxPt_Format('   Input x FxPt format: ' , x);
print_FxPt_Format('   Output y FxPt format: ', y);
print_FxPt_Format('   Variable w FxPt format:', d);

print_FxPt_Format('   Variable MULT1 (w*a) FxPt format:', sma1);
print_FxPt_Format('   Variable ADD1 (Denominator) FxPt format: ', sadd1);

print_FxPt_Format('   Variable MULT2 (w*b) FxPt format: ', smb1);
print_FxPt_Format('   Variable ADD2 (Numerator) FxPt format: ', sadd2);
