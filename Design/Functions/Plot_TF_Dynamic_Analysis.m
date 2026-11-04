



for i=1:4


    
[Num,Den,TS] = TFDATA(H(i),'v');

[h,w] = freqz(Num,Den,1024);       % Retourne le resultat de l'analyse frequentielle sur L points entre 0 et pi
m = abs(h); 

subplot(2,2,i); 
hold on


plot( w./(2*pi),m,'r'); 
title('frequency response'); 
xlabel('Frequency');
ylabel('Gain');
grid on

%log2(max(m))
end
