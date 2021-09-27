#define TMR2PRESCALE 16

#include <xc.h>
    #include <pic18f4520.h>
// BEGIN CONFIG
#pragma config OSC = INTIO67   // Oscillator Selection bits (HS oscillator)
#pragma config WDT = OFF  // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRT = OFF // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON  // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF   // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF   // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)

//END CONFIG

PWM1_Init(long setDuty)
{
  PR2 = setDuty;
}

PWM1_Duty(unsigned int duty)
{
    //set duty to CCPR1L , CCP1X(CCP1CON:5) and CCP1Y(CCP1CON:4)
    //cycle =       16 76                2*10^-6     *     16   =  500   2400    *10^-6
    //           ccpxcon            *   TOSC    *    prescale
   
    if(duty<22)
    CCPR1L = duty;
    else CCPR1L = duty<<11;
            
    //CCPR1L = duty >> 2;
    CCP1CONbits.CCP1X = (duty & 2) >> 1;
    CCP1CONbits.CCP1Y = (duty & 1);
    
}

PWM1_Start()
{
    //set CCP1CON
    CCP1CONbits.CCP1M3 = 1;
    CCP1CONbits.CCP1M2 = 1;
    //set timer2 on
    T2CONbits.TMR2ON = 1;
    //set rc2 output
    TRISCbits.RC2 = 0;


        T2CONbits.T2CKPS1 = 1;
    

  
    PWM1_Init(156);
}

void main()
{
    OSCCONbits.IRCF2 = 0;
    OSCCONbits.IRCF1 = 1;
    OSCCONbits.IRCF0 = 1;
//set FOSC 500khz


    //period = (156+1)*   4  *   2*10^-6      *16    =0.02
//          pr2+1             TOSC          prescale

//cycle =   16 76                2*10^-6  *     16   =  500   2400    *10^-6
//       ccpxcon      *   TOSC    *    prescale




    PWM1_Start();
    int i = 0;//16 48 75
    TRISD = 0xFF;
    int pushed=0;
    do
    {
        if(pushed>0 && i<=80){
             i=i+1;
        }
        else if(RA4 == 1 && i<=76){
            i=i+1;
            pushed++;
        }
        
            
        PWM1_Duty(i);
        char delay = 255;
        for (delay = 255; delay > 0 ; --delay){
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
            asm("nop");
        }
        delay = 0;
        
        if(i==80){
            pushed=0;
            i=0;
        }
            
    }   while(1);

}


