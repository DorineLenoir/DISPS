function    mx = integer_word_length(x,s)

%   Inputs: 
%       x: data dynamic 
%       s : number of sign bit : 0 or 1 
%
%   Output
%       mx : number of bits required to code x

  x_abs=max(abs(x(:)));

  if x_abs==0
      mx=s;
  else
      mx=floor(log2(max(x)))+1+s;
  end
%disp('Fill the code to compute the integer part word-length')

