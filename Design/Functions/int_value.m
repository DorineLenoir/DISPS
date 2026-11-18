function xi = int_value(x,format_x)

%   Inputs:
%       x: real value.
%       format_x : fixed-point format.
%
%   Output
%       xi : integer value having the same binary representtaion as the fixed-point value with the fomrat format_x.

%disp('Fill the code to compute the integer value')


    xq = fx_pt_value(x, format_x);


    xi = round(xq .* 2^format_x.N);

end