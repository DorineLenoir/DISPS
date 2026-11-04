function   m = NormChebychev(H, N, DynIn)

u =  0 : pi/N : pi;

w =  u ./H.Ts;

Hw = freqresp(H,w);
 
m  = DynIn * max(abs(Hw(1,1,1:N))) ;
 
 
   