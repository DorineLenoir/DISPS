

DenCasInt = int_value(DenCas, a);
NumCasInt = int_value(NumCas, b);



FileID = fopen('../Implementation/src/filter_coefficients.h','w');
    
    
fprintf(FileID, 'float a_flpt[4][3] = {');    
    
for i=1:4
    
    fprintf(FileID, ' \n   {%2.10f , %2.10f, %2.10f},    ', DenCas(i,1), -DenCas(i,2), -DenCas(i,3) );

end

fprintf(FileID, '};' );

fprintf(FileID, '\n float b_flpt[4][3] = {');    
    
for i=1:4
    
    fprintf(FileID, ' \n   {%2.10f , %2.10f, %2.10f},    ', NumCas(i,1), NumCas(i,2), NumCas(i,3) );

end

fprintf(FileID, '};' );
        
fprintf(FileID, '\n short int a_fxpt[4][3] = {');    
    
for i=1:4
    
    fprintf(FileID, ' \n   {%d , %d, %d},    ', DenCasInt(i,1), -DenCasInt(i,2), -DenCasInt(i,3) );

end

fprintf(FileID, '};' );

fprintf(FileID, '\n short int b_fxpt[4][3] = {');    
    
for i=1:4
    
    fprintf(FileID, ' \n   {%d , %d, %d},    ', NumCasInt(i,1), NumCasInt(i,2), NumCasInt(i,3) );

end

fprintf(FileID, '};\n' );    
    
    fclose(FileID);
    
disp('Generation of the coefficients in the file ../Implementation/src/filter_coefficients.h')
