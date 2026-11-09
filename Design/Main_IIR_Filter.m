%##########################################################################
%
%   Main .m : 
%
%   Main file for the design of the fixed-point IIR filter     
%
%##########################################################################
close all;
clear all;

addpath('./Filter');
addpath('./RepFreq');
addpath('./Functions');
addpath('./IIR4_2');
addpath('./IIR4_2/Direct_Form_II');
addpath('./IIR4_2/Direct_Form_I');
addpath('./IIR4_2/Transposed_Form');
addpath('../Implementation/testbench/');

Permutation =0
 
% Architecture definition  
    
    Bmem  = 16;         % Data word-length in memory 
    Bmult = 32;         % Output multiplier word-length  
    Badd  = 32;         % Input and output adder word-length    
    
% Dynamic range and IWL for Input Signal    
       
   Dyn_x = 1;  % Input in the range ]-1;1[ 
   
   Mx = 1; 

    
% Filter synthesis and analysis ---------------------------------------------
            
        disp(strcat(sprintf('\n -------------------------------------------------------')));
        disp(strcat(sprintf(' ---- Filter design and analysis-------------------------')));
        disp(strcat(sprintf(' --------------------------------------------------------')));
     
   Filter_Design;           % Filter design   

   Filter_Analysis;         % Impulse and frequency response analysis  
   
% Fixed-point design  ----------------   

        disp(strcat(sprintf('\n -------------------------------------------------------')));
        disp(strcat(sprintf(' ---- Coefficient quantization analysis ------------------')));
        disp(strcat(sprintf(' ---------------------------------------------------------')));
 
    FxPt_Coefficient_Analysis
 
        disp('Press any key to continue');
        pause

   
 
        disp(strcat(sprintf('\n -------------------------------------------------------')));
        disp(strcat(sprintf(' ---- Fixed-point design of the cascaded form ------------')));
        disp(strcat(sprintf(' ---------------------------------------------------------')));
 
    Dynamic_Range_Det_Cascaded_Form;          % Dynamic range evaluation  
%    
   % Direct Form I 
%         disp(strcat(sprintf('\n -------------------------------------------------------')));
%         disp(strcat(sprintf(' ---- Cascaded form I ------------------------------------')));
%         disp(strcat(sprintf(' ---------------------------------------------------------')));
%  
%    
%    FxPt_Specif_Det_IIR_Direct_Form_I;           % Fixed-point format determination  
%    
%    sim('IIR_Direct_Form_I');                    % Fixed-point and floating-point simulation 
%    
%    analyze_Q_noise_simulink;
%     
%    disp('Press any key to continue');
%    pause
%    
   % Calcul du RSBQ en sortie du filtre 
   % Direct Form II 
   
        disp(strcat(sprintf('\n -------------------------------------------------------')));
        disp(strcat(sprintf(' ---- Cascaded form II ------------------------------------')));
        disp(strcat(sprintf(' ---------------------------------------------------------')));

   FxPt_Specif_Det_IIR_Direct_Form_II;           % Fixed-point format determination  
   
   sim('IIR_Direct_Form_II');                    % Fixed-point and floating-point simulation 
    
   disp(sprintf('\n Quantization noise power (dB) at the output of the cascaded filter (direct form II) simulation '));
   
   analyze_Q_noise_simulink;
  
   disp('Press any key to continue');
   pause 
  
  % Forme transpose 
   
%   FxPt_Specif_Det_IIR_Transposed_Form;  % Fixed-point format determination   
%    
%   sim('IIR_Transposed_Form');              % Fixed-point and floating-point simulation 
%    
%   disp(sprintf('\n Quantization noise power (dB) at the output of the cascaded filter (transposed form) simulation '));
%    
%   disp(10*log10(var(y_flottant-y_fix)))  % Quantization noise power computation
  
  generate_coefficients
   
