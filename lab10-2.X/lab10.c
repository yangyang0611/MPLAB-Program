/*
 * File:   lab9.c
 * Author: huang
 *
 * Created on 2019?12?2?, ?? 3:47
 */

#include <xc.h>
#include <PIC18F4520.h>
#include<stdio.h>


#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit 
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON   // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
#define _XTAL_FREQ 200000
unsigned int x;
void __interrupt(high_priority) myIsr(void){

   
   INTCONbits.GIEH=0b0;
    unsigned int temp1=0xFF;
    x=3;
    x=x&(unsigned int)ADRESH;
    x=x<<8;
    temp1=temp1&(unsigned int)ADRESL;
    x+=temp1;
    if(0<=x&&x<68){
        LATD=0x00;
    }  
    else if(68<=x&&x<136){
        LATD=0x01;
    }
    else if(136<=x&&x<204){
        LATD=0x02;
    }
    else if(204<=x&&x<272){
        LATD=0x03;
    }
    else if(272<=x&&x<340){
        LATD=0x04;
    }
    else if(340<=x&&x<408){
        LATD=0x05;
    }
    else if(408<=x&&x<476){
        LATD=0x06;
    }
    else if(476<=x&&x<544){
        LATD=0x07;
    }
    else if(544<=x&&x<612){
        LATD=0x08;
    }
    else if(612<=x&&x<680){
        LATD=0x09;
    }
     else if(680<=x&&x<744){
         LATD=0x0A;
    }
     else if(744<=x&&x<808){
         LATD=0x0B;
    }
     else if(808<=x&&x<876){
         LATD=0x0C;
    }
     else if(876<=x&&x<944){
         LATD=0x0D;
    }
     else if(944<=x&&x<1000){
         LATD=0x0E;
    }
     else if(x>=1000){
         LATD=0x0F;
    }
    INTCONbits.GIEH=0b1;
    PIR1bits.ADIF=0b0;
    ADCON0bits.GO_nDONE=0b1;
    _delay(50);
    
    
}

#pragma code
void main(void) {
 
 //oscillator frequency=4MHZ
    OSCCONbits.IRCF = 0b110;
 //Initialize TRISD
    TRISDbits.TRISD0=0b0;
    TRISDbits.TRISD1=0b0;
    TRISDbits.TRISD2=0b0;
    TRISDbits.TRISD3=0b0;
    LATDbits.LATD0=0b0;
    LATDbits.LATD1=0b0;
    LATDbits.LATD2=0b0;
    LATDbits.LATD3=0b0;
    
 
 //select VREF default Vss Vdd   
    ADCON1bits.VCFG1=0b0;
    ADCON1bits.VCFG0=0b0;
 //select port control
    ADCON1bits.PCFG=0b1110;
 //select input channel AN0
    ADCON0bits.CHS=0b0000;
 //select conversion clock
    ADCON2bits.ADCS=0b100;    
//select acquisition time
    ADCON2bits.ACQT=0b010;
//Turn on module
    ADCON0bits.ADON=0b1;
//select justified method
    ADCON2bits.ADFM=0b1;
//initializing interrupt
    RCONbits.IPEN=0b1;
    INTCONbits.GIEH=0b1;
    
    PIE1bits.ADIE=0b1;
    PIR1bits.ADIF=0b0;
    IPR1bits.ADIP=0b1;
    
    ADCON0bits.GO_nDONE=0b1;
                
    while(1);

    return;
}
