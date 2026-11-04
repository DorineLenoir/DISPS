/**
 * \file      main.c
 * \author    D. MENARD, L. BOURDEL
 * \version   2.0
 * \date      2018
 * \brief     Main function
 *
 * \details   Simultion with STM32
 *
 */
 
#include <math.h>

#define Npts    1024

/* ------------------------------------------------------------------------*/
/* Fichiers de définition                                                     */
/* ------------------------------------------------------------------------*/

#include "source_signal.h"
#include "stdio.h"


/* ------------------------------------------------------------------------*/
/* Function Prototypes                                                     */
/* ------------------------------------------------------------------------*/

extern short int IIR_filter_fxpt (short int x);
extern short int IIR_filter_fxpt_opt1 (short int x);
extern short int IIR_filter_fxpt_opt2 (short int x);

extern float     IIR_filter_flpt (float x) ;


short int tab_out_fxpt_ref[Npts];
short int tab_out_fxpt_test[Npts];
float     tab_out_flpt[Npts];


int main()
{
    short int n;
    
    
    for(n=0; n< Npts; n++)
    {
        
        /* L'entree est en format virgule fixe cadree a gauche */
        
        tab_out_fxpt_ref[n]  = IIR_filter_fxpt_opt1 (tab_in_fxpt[n]) ;
        tab_out_fxpt_test[n] = IIR_filter_fxpt_opt2 (tab_in_fxpt[n]) ;
        tab_out_flpt[n]      = IIR_filter_flpt (tab_in_flpt[n]) ;
    }
    
   
    
}
