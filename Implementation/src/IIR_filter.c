#include <math.h>

/* ------------------------------------------------------------------------*/ 
/* Include files  												           */
/* ------------------------------------------------------------------------*/ 


#include "filter_coefficients.h"

/* ------------------------------------------------------------------------*/
/* constant definition 												       */
/* ------------------------------------------------------------------------*/ 

#define 	N			4

/* ------------------------------------------------------------------------*/ 
/* Global variables                                      				   */
/* ------------------------------------------------------------------------*/ 




 
/* ------------------------------------------------------------------------*/
/* IIR 8 filter in floating-point                                          */
/* ------------------------------------------------------------------------*/

float  IIR_filter_flpt(float x)
{



    static float X_flpt[N+1];
    static float w[N][3];


    X_flpt[0] = x;
int i;
 
    for(i=0; i<N; i++)
    {
    /* on veillit avant car cela nous permet de conserver les valeurs pour éviter de les écraser*/
    w[i][2]=w[i][1];
    w[i][1]=w[i][0];

    /* w(n)=x(n)+a1*w(n-1)+a2*w(n-2)*/
    w[i][0]=X_flpt[i]+w[i][1]*a_flpt[i][1]+w[i][2]*a_flpt[i][2];
    
    /* y(n)=b0*x(n)+b1*x(n-1)+b2*x(n-2) -> transporte la valeur de sortie de la cellule*/
    X_flpt[i+1]=w[i][0]*b_flpt[i][0]+w[i][1]*b_flpt[i][1]+w[i][2]*b_flpt[i][2];

    }
/* on return la valeur sortante de la dernière cellule du filtre*/
    return X_flpt[N];

}

/* ------------------------------------------------------------------------*/
/* IIR 8 filter in fixed-point                                          */
/* ------------------------------------------------------------------------*/

short int IIR_filter_fxpt(short int x)
{
    static short int w[N][3];

    long int X_fxpt,acc2;


    long int w_long;/* sert à stocker le calcul de w(n) en Q7.25 avant de le décaler pour passer en Q5.11*/
    /* en entrée en passe de Q1.15 à Q7.25 -> 25-15 =10 donc <<10*/
X_fxpt=((long int)x)<<10;
int i;
for (i=0; i<N;i++){

    /* on calcule w(n) en Q7.25*/
    w_long=X_fxpt+w[i][1]*(a_fxpt[i][1])+w[i][2]*(a_fxpt[i][2]);

    /*ensuite on decale q7.25 pour passer en Q5.11*/
    w[i][0]=(short int)(w_long>>14);

    /* Q6.26 en Q7.25 donc >>1*/
    acc2=(w[i][0]*b_fxpt[i][0]+w[i][1]*b_fxpt[i][1]+w[i][2]*b_fxpt[i][2])>>1;
w[i][2]=w[i][1];
w[i][1]=w[i][0];
    X_fxpt=acc2;

}
/* Q7.25 en Q2.14 donc >> 11*/

return (short int)(X_fxpt>>11);

}
