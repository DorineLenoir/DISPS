
Fe   = 12000;
Npts = 1024;
Pas  = Fe / Npts;

LoadSigOut;

figure;
subplot( 2, 2, 1 );
plot(  TabX_float , 'r' );
legend( 'TabX Float' );
subplot( 2, 2, 2 );
plot(  TabY_float , 'b' );
legend( 'TabY Float' );

subplot( 2, 2, 3 );
plot(  TabX_fixed , 'r' );
legend( 'TabX Fixed' );
subplot( 2, 2, 4 );
plot( TabY_fixed , 'b' );
legend( 'TabY Fixed' );



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

