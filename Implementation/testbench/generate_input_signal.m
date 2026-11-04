
Fe = 16000;
Npts = 1024;

Fdebut = 1000;
Ffinal = 5000;

Q = 15;

Te = 1/Fe; 

t = 0:Te:(Npts-1)*Te;

x = 0.9 * chirp(t,Fdebut,(Npts-1)*Te,Ffinal);

xfix = round(x*2^Q);

    FileID = fopen('SignalSource.h','w');    
    
    
fprintf(FileID, 'float TabX_float[%i] = {', Npts);
    
    
for i=1:length(xfix)-1
    
    fprintf(FileID, '%2.10f, \n   ', x(i) );

end


    fprintf(FileID, '%2.10f};', x(length(x)) );
        
    
    fprintf(FileID, 'int TabX_fixed[%i] = {', Npts);
    
    
for i=1:length(xfix)-1
    
    fprintf(FileID, '%i, \n   ', xfix(i) );

end


    fprintf(FileID, '%i};', xfix(length(xfix)) );
    
    fclose(FileID);
    