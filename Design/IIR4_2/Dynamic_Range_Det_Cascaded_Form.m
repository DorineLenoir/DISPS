%##########################################################################
%
%   Dynamic_Range_Det_Cascaded_Form.m : 
%
%   Dynamic range evaluation for the cascaded form   
%
%   Input: 
%       - NumCas (4*3): Cascaded filter Numerator  
%       - DenCas (4*3): Cascaded filter Denominator
%
%   Output:   
%       - My : Binary-point position for the output y(n) of a generic cell
%       - Mw : Binary-point position for the intermediate variable w(n) 
%              of a generic cell for Direct Form II
%
%   Fonction : 
%       - Computation of the dynamic range y(n) et w(n) for the 4 cells 
%
%##########################################################################
 
% Transfer function definition 

  % Filter 1 ----------------------------------------------------  
   
   Hn1 = tf(NumCas(1,:),1 , Te,'Variable','z^-1');  % Hn1(z) = Y1(z)/W1(z)
   Hd1 = tf(1 ,DenCas(1,:), Te,'Variable','z^-1');  % Hd1(z) = W1(z)/X(z)
   H1 = Hd1 * Hn1;                                  % H1(z)  = Y1(z)/X(z)
     
  % Filter 2 ----------------------------------------------------
     
   Hn2 = tf(NumCas(2,:),1 , Te,'Variable','z^-1');  % Hn2(z) = Y2(z)/W2(z)
   Hd2 = tf(1 ,DenCas(2,:), Te,'Variable','z^-1');  % Hd2(z) = W2(z)/X2(z)
   H2 = Hd2 * Hn2;                                  % H2(z)  = Y2(z)/X2(z)

  % Filter 3 ----------------------------------------------------
   
   Hn3 = tf(NumCas(3,:),1 , Te,'Variable','z^-1');  % Hn3(z) = Y3(z)/W3(z)
   Hd3 = tf(1 ,DenCas(3,:), Te,'Variable','z^-1');  % Hd3(z) = W3(z)/X3(z)
   H3 = Hd3 * Hn3;                                  % H3(z)  = Y3(z)/X3(z)

  % Filter 4 ----------------------------------------------------
     
   Hn4 = tf(NumCas(4,:),1 , Te,'Variable','z^-1');  % Hn4(z) = Y4(z)/W4(z)
   Hd4 = tf(1 ,DenCas(4,:), Te,'Variable','z^-1');  % Hd4(z) = W4(z)/X4(z)
   H4 = Hd4 * Hn4;                                  % H4(z)  = Y4(z)/X4(z)

   
   N_norm = 2048;           % Number of sample used to computed the norm
   
   
   
% Dynamic range for y(n) 
   
   % Transfer functions to compute the dynamic range of yi(n)

   disp('Fill the code')

   H_y1 = H1;
   H_y2 =H1*H2;                             %fait bien tout seul car on est en objet
   H_y3 =H1*H2*H3;
   H_y4 =H1*H2*H3*H4;
   
   % Dynamic range for y_i(n) 
 
   Dyn_y1_L1    = dynamic_norm_L1(   H_y1, N_norm,Dyn_x); 
   Dyn_y1_Cheby = dynamic_norm_Cheby(H_y1, N_norm, Dyn_x); 
   M_y1_L1      = integer_word_length(Dyn_y1_L1,1);
   M_y1_Cheby   = integer_word_length(Dyn_y1_Cheby,1);
   print_Dyn('y1',Dyn_y1_L1,M_y1_L1,Dyn_y1_Cheby,M_y1_Cheby); 
   
   Dyn_y2_L1    = dynamic_norm_L1(   H_y2, N_norm,Dyn_x); 
   Dyn_y2_Cheby = dynamic_norm_Cheby(H_y2, N_norm, Dyn_x); 
   M_y2_L1      = integer_word_length(Dyn_y2_L1,1);
   M_y2_Cheby   = integer_word_length(Dyn_y2_Cheby,1);
   print_Dyn('y2',Dyn_y2_L1, M_y2_L1, Dyn_y2_Cheby, M_y2_Cheby); 
        
   Dyn_y3_L1    = dynamic_norm_L1(   H_y3, N_norm,Dyn_x); 
   Dyn_y3_Cheby = dynamic_norm_Cheby(H_y3, N_norm, Dyn_x); 
   M_y3_L1      = integer_word_length(Dyn_y3_L1,1);
   M_y3_Cheby   = integer_word_length(Dyn_y3_Cheby,1);
   print_Dyn('y3',Dyn_y3_L1, M_y3_L1, Dyn_y3_Cheby, M_y3_Cheby); 
        
   Dyn_y4_L1    = dynamic_norm_L1(   H_y4, N_norm,Dyn_x); 
   Dyn_y4_Cheby = dynamic_norm_Cheby(H_y4, N_norm, Dyn_x); 
   M_y4_L1      = integer_word_length(Dyn_y4_L1,1);
   M_y4_Cheby   = integer_word_length(Dyn_y4_Cheby,1);
   print_Dyn('y4',Dyn_y4_L1, M_y4_L1, Dyn_y4_Cheby, M_y4_Cheby); 
             
   M_y_L1 = max( [M_y1_L1 M_y2_L1 M_y3_L1 M_y4_L1] ); 
   M_y_Cheby = max( [M_y1_Cheby M_y2_Cheby M_y3_Cheby M_y4_Cheby] ); 

   % Transfer functions to compute the dynamic range of yi(n)

    disp('Fill the code')

   H_w1 = Hd1;
   H_w2 =H1*Hd2;
   H_w3 =H1*H2*Hd3;
   H_w4 =H1*H2*H3*Hd4;
   
   % Dynamic range for w_i(n) 
 
   Dyn_w1_L1    = dynamic_norm_L1(   H_w1, N_norm,Dyn_x); 
   Dyn_w1_Cheby = dynamic_norm_Cheby(H_w1, N_norm, Dyn_x); 
   M_w1_L1      = integer_word_length(Dyn_w1_L1,1);
   M_w1_Cheby   = integer_word_length(Dyn_w1_Cheby,1);
   print_Dyn('w1',Dyn_w1_L1,M_w1_L1,Dyn_w1_Cheby,M_w1_Cheby); 
   
   Dyn_w2_L1    = dynamic_norm_L1(   H_w2, N_norm,Dyn_x); 
   Dyn_w2_Cheby = dynamic_norm_Cheby(H_w2, N_norm, Dyn_x); 
   M_w2_L1      = integer_word_length(Dyn_w2_L1,1);
   M_w2_Cheby   = integer_word_length(Dyn_w2_Cheby,1);
   print_Dyn('w2',Dyn_w2_L1, M_w2_L1, Dyn_w2_Cheby, M_w2_Cheby); 
        
   Dyn_w3_L1    = dynamic_norm_L1(   H_w3, N_norm,Dyn_x); 
   Dyn_w3_Cheby = dynamic_norm_Cheby(H_w3, N_norm, Dyn_x); 
   M_w3_L1      = integer_word_length(Dyn_w3_L1,1);
   M_w3_Cheby   = integer_word_length(Dyn_w3_Cheby,1);
   print_Dyn('w3',Dyn_w3_L1, M_w3_L1, Dyn_w3_Cheby, M_w3_Cheby); 
        
   Dyn_w4_L1    = dynamic_norm_L1(   H_w4, N_norm,Dyn_x); 
   Dyn_w4_Cheby = dynamic_norm_Cheby(H_w4, N_norm, Dyn_x); 
   M_w4_L1      = integer_word_length(Dyn_w4_L1,1);
   M_w4_Cheby   = integer_word_length(Dyn_w4_Cheby,1);
   print_Dyn('w4',Dyn_w4_L1, M_w4_L1, Dyn_w4_Cheby, M_w4_Cheby); 
             
   M_w_L1 = max( [M_w1_L1 M_w2_L1 M_w3_L1 M_w4_L1] ); 
   M_w_Cheby = max( [M_w1_Cheby M_w2_Cheby M_w3_Cheby M_w4_Cheby] ); 


   My = M_y_Cheby;
   Mw = M_w_Cheby; 
 
   disp(strcat(sprintf('\n Dynamic range of yi(n) : '), num2str(My))); 
   disp(strcat(sprintf('\n Dynamic range of wi(n) : '), num2str(Mw))); 
   
   

   
   
