function xq = fx_pt_value(x,format_x)

%   Inputs:
%       x: real value.
%       format_x : fixed-point format.
%
%   Output
%       xq : fixed-point value according to  the fomrat of x.

N=format_x.N;

xint=round(x*2^N);
xq=xint*2^(-N);
%disp('Fill the code to compute the fixed-point value')


