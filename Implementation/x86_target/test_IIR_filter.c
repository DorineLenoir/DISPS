#include <math.h>

#define Npts    1024

/* ------------------------------------------------------------------------*/ 
/* Fichiers de définition  												   */ 
/* ------------------------------------------------------------------------*/ 

#include "source_signal.h"
#include "stdio.h"	


/* ------------------------------------------------------------------------*/  
/* Function Prototypes                                                     */
/* ------------------------------------------------------------------------*/ 

extern short int IIR_filter_fxpt (short int x);

extern float     IIR_filter_flpt (float x) ;




int main()
{
short int n;
short int tab_out_fxpt[Npts];
float     tab_out_flpt[Npts];

FILE * pFile; 

	 for(n=0; n< Npts; n++)
	 {
	
     	/* L'entree est en format virgule fixe cadree a gauche */
     	
     	tab_out_fxpt[n] = IIR_filter_fxpt (tab_in_fxpt[n]) ;
     	tab_out_flpt[n] = IIR_filter_flpt (tab_in_flpt[n]) ;
	 }

	pFile = fopen ("../testbench/LoadSigOut.m","w+");

	/* Sauvegarde  de y fixe */

	fprintf(pFile,"TabX_fixed = ["); 
	
	for(n=0; n< Npts; n++){

		fprintf(pFile,"%i \n",tab_in_fxpt[n]);
	}

	fprintf(pFile,"];\n");
	
	/* Sauvegarde  de y fixe */
	
	fprintf(pFile,"TabY_fixed = ["); 
	 
	for(n=0; n< Npts; n++){

        fprintf(pFile,"%i \n",tab_out_fxpt[n]);
        
    }

	fprintf(pFile,"];\n");
	
	/* Sauvegarde  de y flottant */

	fprintf(pFile,"TabX_float = ["); 
	
	for(n=0; n< Npts; n++){

		fprintf(pFile,"%2.10f \n",tab_in_flpt[n]);
	}

	fprintf(pFile,"];\n");
	
	/* Sauvegarde  de y flottant */
	
	fprintf(pFile,"TabY_float = ["); 
	 
	for(n=0; n< Npts; n++){

        fprintf(pFile,"%2.10f \n",tab_out_flpt[n]);
    }

	fprintf(pFile,"];\n");
	fclose (pFile);

}
