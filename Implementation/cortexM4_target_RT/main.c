/**
 * \file      main.c
 * \author    D. MENARD, L. BOURDEL
 * \version   2.0
 * \date      2018
 * \brief     Main function
 *
 * \details   DSP system with 
 *							- ADC IN  PA0 
 *							- DAC OUT PA4
 *							- Sampling clock PA1
 *
 */
 
#include "main.h"
#include "stm32_periph.h"

#define N_pts   256

short new_period = 0;
short ADC_val = 0;
short DAC_val = 0;
short tab_ADC[N_pts];
short tab_DAC[N_pts];


/* FOR DEBUG http://www.keil.com/appnotes/docs/apnt_286.asp § 19) Configuring Serial Wire Viewer (SWV):


DON'T FORGET to set SystemCoreClock in Debug/Trace windows
+
22) printf with ITM

*/

/* ------------------------------------------------------------------------*/
/* Function Prototypes                                                     */
/* ------------------------------------------------------------------------*/

extern short int IIR_filter_fxpt (short int x);

extern float     IIR_filter_flpt (float x) ;


/*****************************************************************************/
/**
 * \fn       init_GPIO_DSP()
 *
 * \brief    Initialisation of the gpio for the DSP system
 *
 *		PA1 : clock for the ADC and DAC
 *	  PA0 ADC IN 0
 *		PA3 ADC IN 3
 *		PA4 ADC OUT 1
 *		PA5 ADC OUT 2
 */
/*****************************************************************************/

void init_GPIO_DSP()
{
	// Enable GPIO clock
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	
	// PORTA :  
	GPIOA->MODER   &= ~GPIO_MODER_MODE1_Msk;  
	GPIOA->MODER   |=  GPIO_MODE_AF_PP  << GPIO_MODER_MODE1_Pos; 
	
	// Alternate function for TIM2
	GPIOA->AFR[0] &= ~GPIO_AFRL_AFSEL1;  // Reset fields to 0 for PB 8+9+10
	GPIOA->AFR[0] |=  GPIO_AF1_TIM2 << GPIO_AFRL_AFSEL1_Pos;  // Set to PB 8+9+10 GPIO_AF1_TIM2=0x1
	
	
	//Configure the Port A pin 0 to be the Analogue Mode
	
	GPIOA->MODER   &= ~ (GPIO_MODER_MODE0_Msk | GPIO_MODER_MODE3_Msk |GPIO_MODER_MODE4_Msk | GPIO_MODER_MODE5_Msk );  
	GPIOA->MODER |= GPIO_MODE_ANALOG <<  GPIO_MODER_MODE0_Pos;
	GPIOA->MODER |= GPIO_MODE_ANALOG <<  GPIO_MODER_MODE3_Pos;
	GPIOA->MODER |= GPIO_MODE_ANALOG <<  GPIO_MODER_MODE4_Pos;
	GPIOA->MODER |= GPIO_MODE_ANALOG <<  GPIO_MODER_MODE5_Pos;
	
	GPIOA->MODER   &= ~ (GPIO_MODER_MODE6_Msk | GPIO_MODER_MODE7_Msk |GPIO_MODER_MODE8_Msk | GPIO_MODER_MODE9_Msk );  
	
	GPIOA->MODER |= GPIO_MODE_OUTPUT_PP	<<  GPIO_MODER_MODE6_Pos;
	GPIOA->MODER |= GPIO_MODE_OUTPUT_PP	<<  GPIO_MODER_MODE7_Pos;
	GPIOA->MODER |= GPIO_MODE_OUTPUT_PP	<<  GPIO_MODER_MODE8_Pos;
	GPIOA->MODER |= GPIO_MODE_OUTPUT_PP	<<  GPIO_MODER_MODE9_Pos;
	
	
	 		
}


/*****************************************************************************/
/**
 * \fn       init_TIM2_counter_radar_US()
 *
 * \brief    Initialisation of the counter of timer TIM2
 */
/*****************************************************************************/

void init_TIM2_DSP(void)
{
	// Enable clock TIM2
	// APB1 bus
			RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;
	
		/* Select the Counter Mode */
			TIM2->CR1 &= ~(TIM_CR1_DIR | TIM_CR1_CMS); // Reset before to set

	  /* Set the Prescaler value */     //	TIM2->PSC = 180; // 1Mhz
			TIM2->PSC = 15; // 1Mhz/5.88==170Khz~5.88µs : PSC=180*5.88 : To have direct result without to divide by 58

	  /* Set the Auto-reload value */   //	TIM2->ARR = 60000; // 60ms
			TIM2->ARR = 1000;  

	//************************************* Compare PWM Channel 1

    // Output compare mode
      TIM2->CCMR1 &= ~TIM_CCMR1_OC2M_Msk;
      TIM2->CCMR1 |=  TIM_OCMODE_PWM1   << (TIM_CCMR1_OC2M_Pos - TIM_CCMR1_OC1M_Pos) ;    // PWM Mode 1

    // Output Compare preload enable
      TIM2->CCMR1 |=  TIM_CCMR1_OC2PE_Msk; //    1: Preload register on TIMx_CCR1 enabled.

    //  capture/compare register 1
      TIM2->CCR2 	 = 500;            // Output Compare Register for channel 2

    // Bit 0  CC1E: Compare 1 output enable
      TIM2->CCER 	 	|= TIM_CCER_CC2E; // Enable output for ch1
			
      TIM2->CR1 |= TIM_CR1_CEN;
}


void init_ADC_DSP(void) {
	
	//Enable the clock for ADC module and GPIO Port A
	RCC->APB2ENR|=RCC_APB2ENR_ADC1EN;
  
	
	//Set the prescaler for the clock
	RCC->CFGR|=RCC_CFGR_PPRE2_DIV2;
	
  /* Conversion time */
    
	//Set ADC prescaler, divided by 4
	  ADC->CCR &=~ADC_CCR_ADCPRE;
    ADC->CCR |= ADC_CLOCK_SYNC_PCLK_DIV4;
    
    //Set ADC conversion time : 28 cycles
    ADC1->SMPR2 &=~ADC_SMPR2_SMP8;
    ADC1->SMPR2 |= ADC_SAMPLETIME_480CYCLES << ADC_SMPR2_SMP8_Pos;
    
    /* Conversion mode : single chanel, single conversion */
    
    ADC1->CR1 &=~ ADC_CR1_SCAN;
    ADC1->CR1 &=~ ADC_CR1_DISCEN;
    ADC1->CR2 &=~ ADC_CR2_CONT;
    
    /* Conversion triggering TIM2_CC3 rising edge  */
    
    ADC1->CR2 &=~ ADC_CR2_EXTEN;
    ADC1->CR2 |=  ADC_EXTERNALTRIGCONVEDGE_RISING ;
    
    ADC1->CR2 &=~ ADC_CR2_EXTSEL;
    ADC1->CR2 |=  ADC_EXTERNALTRIGCONV_T2_CC2 ;
    
    /* Conversion on 10 bits right align   */
    
    ADC1->CR1 &=~ ADC_CR1_RES;
    ADC1->CR1 |=  ADC_RESOLUTION_12B << ADC_CR1_RES_Pos;
    
    ADC1->CR2 &=~ ADC_CR2_ALIGN;
    ADC1->CR2 |=  ADC_DATAALIGN_RIGHT << ADC_CR2_ALIGN_Pos;
    
    /* AD conversion sequence definition   */
    
    ADC1->SQR1 &=~ ADC_SQR1_L;   // Sequence of length 1.
    
    ADC1->SQR3 &=~ ADC_SQR3_SQ1;
    ADC1->SQR3 |=  0 << ADC_SQR3_SQ1_Pos;  // Channel 8
    
    /* IT for End Of Conversion    */
    
    ADC1->CR1 |= ADC_CR1_EOCIE;
    
    NVIC_SetPriority(ADC_IRQn,3);
    NVIC_ClearPendingIRQ(ADC_IRQn);
    NVIC_EnableIRQ(ADC_IRQn);
    
    //Power up the ADC module
    ADC1->CR2|=ADC_CR2_ADON;

}


void ADC_IRQHandler()
{
   if((ADC1->SR & ADC_SR_EOC))
    {
			ADC1->SR &= ~ADC_SR_EOC; 
			
			GPIOA->ODR = GPIOA->IDR ^ (0x01 << PA_6) ; 
			
			ADC_val = ADC1->DR;
			
			DAC->DHR12R1 =  DAC_val;
			
            new_period = 1;
    
    }
}

void init_DAC_DSP(void) {
	// Enable the internal DAC targeting an external pin,
	// and any clock sources required to start the DAC.

	
	//Enable the clock for DAC module and GPIO Port A
	RCC->APB1ENR|=RCC_APB1ENR_DACEN;

	
	//Enable the DAC
	DAC->CR|=DAC_CR_EN1;

	
	//Write to the DAC channel1 12-bit left-aligned data holding register
	DAC->DHR12R1=0;
}




/*----------------------------------------------------------------------------
 MAIN function
 *----------------------------------------------------------------------------*/
  

/**
 * \brief     Main function entry
 * \details   
 * \return    \e none.
 */
int main(void){

int i=0;

// Switch System Clock to maximum
// F446 : 180Mhz, Apb1BusClock = Apb2BusClock = 180Mhz
	System_Clock_Init(); 
	
	init_GPIO_DSP();
	
	init_TIM2_DSP(); 

	init_ADC_DSP(); 

	init_DAC_DSP(); 

	
	while(1)
	{
        if(new_period == 1)
        {
            new_period = 0;
            
            tab_ADC[i] = ADC_val ;
            
            DAC_val = ADC_val;
            
            
            tab_DAC[i] = DAC_val ;
            
            i++;
            
            if(i == N_pts)
            {
                i=0;
            }
        }
	}
}


