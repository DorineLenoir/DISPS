
Fe   = 12000;
Npts = 1024;
Pas  = Fe / Npts;

LoadSigOut;

figure;
subplot( 2, 2, 1 );
plot( 0:Pas:Fe-Pas, abs( fft( TabX_float )), 'r' );
legend( 'TabX Float' );
subplot( 2, 2, 2 );
plot( 0:Pas:Fe-Pas, abs( fft( TabY_float ))./ abs( fft( TabX_float )), 'b' );
legend( 'H(f) Float' );

subplot( 2, 2, 3 );
plot( 0:Pas:Fe-Pas, abs( fft( TabX_fixed )), 'r' );
legend( 'TabX Fixed' );
subplot( 2, 2, 4 );
plot( 0:Pas:Fe-Pas, abs( fft( TabY_fixed*2^-y.N ))./ abs( fft( TabX_fixed*2^-x.N )), 'b' );
legend( 'H(f) Fixed' );

ex = TabX_fixed*2^-15 - TabX_float;
ey = TabY_fixed*2^-14 - TabY_float;

figure
subplot(2,1,1)
hist(ex,50)
subplot(2,1,2)
hist(ey,50)

disp('mean ex')
mean(ex)
disp('var ex')
var(ex)

disp('Power ex (dB)')
10 * log10(mean(ex)^2 + var(ex))

disp('mean ey')
mean(ey)
disp('var ey')
var(ey)

disp('Power ey (dB)')
10 * log10(mean(ey)^2 + var(ey))


figure
subplot(2,2,1)
plot(xcorr(ex))
subplot(2,2,2)
plot(abs(fft(xcorr(ex))))

subplot(2,2,3)
plot(xcorr(ey-mean(ey)))
subplot(2,2,4)
plot(abs(fft(xcorr(ey-mean(ey)))))


