/*
 * File:   lab9.c
 * Author: huang
 *
 * Created on 2019?12?2?, ?? 3:47
 */

#include <xc.h>
#include <pic18f4520.h>


#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit 
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON   // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
#define _XTAL_FREQ 200000
void main(void) {
    // ??TIMER2, prescaler?4
    T2CON = 0b01111101;

    // ??OSC???Fosc?125k = Tosc?8탎
    OSCCONbits.IRCF = 0b001;
    
    // ??CCP1
    CCP1CONbits.CCP1M = 0b1100;
    
    // ?RC2??????????(??CCP1?RC2????port)
    TRISC = 0;
    LATC = 0;
    TRISB=1;
    PORTB=0;
    PORTBbits.RB0=0;
    // ??pr2?ccp?????????PWM???Duty Cycle
    // period = (PR2+1)*4*Tosc*(TMR2 prescaler) = (0x9b + 1) * 4 * 8탎 * 4 = 0.019968s ~= 20ms
    PR2 = 0x9b;
    // duty cycle = (CCPR1L:CCP1CON<5:4>)*Tosc*(TMR2 prescaler) = (0x0b*4 + 0b01) * 8탎 * 4 = 0.00144s ~= 1450탎
//    CCPR1L = 0x0b;
//    CCP1CONbits.DC1B = 0b01;
    
    CCPR1L = 0x01;
    CCP1CONbits.DC1B = 0b11;
    
    int state=0;
    while(1){
        if(PORTB==1){
            PORTB=0;
            int i=0,j=0;
            
            for(i=1;i<19;i++){
                CCP1CONbits.DC1B = 0b00;
                CCPR1L=i;
                for(j=0;j<4;j++){
                    if(j==0){
                         __delay_ms(10);
                        CCP1CONbits.DC1B = 0b00;
                    }
                    else if(j==1){
                         __delay_ms(10);
                        CCP1CONbits.DC1B = 0b01;
                    }
                    else if(j==2){
                     __delay_ms(10);
                        CCP1CONbits.DC1B = 0b10;
                    }
                    else if(j==3){
                    __delay_ms(10);
                        CCP1CONbits.DC1B = 0b11;
                    }                  
                }
            }
             CCP1CONbits.DC1B = 0b11;
             CCPR1L=1;
            
            
        } 
//        if(PORTB==1){
//                if(state==0){
//                    CCPR1L = 0b00010010;
//                    CCP1CONbits.DC1B = 0b11;
//                    PORTB=0;
//                    state=1;
//                }
//                else{
//                    state=0;
//                     CCPR1L = 0x01;
//                     CCP1CONbits.DC1B = 0b11;
//                     PORTB=0;
//                }
//        }
    }
    while(1);
    // Demo????TAs??????Tosc?PR2??CCPR1L?CCP1CON????????????20ms??duty cycle?500탎?2400탎?
    return;
}