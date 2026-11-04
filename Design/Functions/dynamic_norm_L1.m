function    m = NormL1(H, N, DynIn)

%   Inputs: 
%       H: transfer function
%       N: number of point for the evaluation of the impulse response 
%       DynIn: input dynamic 
%
%   Output
%       m: number of bits required to code the output of the system H

H_1 = H; 
H_1.Ts = 1; 


 h = impulse(H_1,N);
 m  = DynIn*sum(abs(h)) ;