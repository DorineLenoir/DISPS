
ex = x_flottant-x_fix;
ey = y_flottant-y_fix;



disp(sprintf('\n Quantization noise power (dB) at the input of the cascaded filter  '));
   
10 * log10(mean(ex)^2 + var(ex))

disp(sprintf('\n Quantization noise power (dB) at the output of the cascaded filter '));

10 * log10(mean(ey)^2 + var(ey))

figure 

subplot(2,1,1)
hist(ex,50)
title('Probability Mass Function for the filter input noise'); 

subplot(2,1,2)
hist(ey,50)
title('Probability Mass Function for the filter ouput noise'); 

figure

subplot(2,2,1)
plot(xcorr(ex))
title('Autocorrelation function for the filter input noise'); 

subplot(2,2,2)
plot(abs(fft(xcorr(ex))))
title('Power Spectrum Density for the filter input noise'); 


subplot(2,2,3)
plot(xcorr(ey-mean(ey)))
title('Autocorrelation function for the filter output noise'); 

subplot(2,2,4)
plot(abs(fft(xcorr(ey-mean(ey)))))
title('Power Spectrum Density for the filter output noise'); 


