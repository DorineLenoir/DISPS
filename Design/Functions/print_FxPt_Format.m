function     AfficheFormat(Str,X) 

 disp(strcat(Str, sprintf('Q'), num2str(X.M),sprintf('. '),num2str(X.N),sprintf('( '), num2str(X.B),sprintf(' bits'),sprintf(') ')))  
