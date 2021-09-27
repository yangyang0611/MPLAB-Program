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
    
    // ??pr2?ccp?????????PWM???Duty Cycle
    // period = (PR2+1)*4*Tosc*(TMR2 prescaler) = (0x9b + 1) * 4 * 8탎 * 4 = 0.019968s ~= 20ms
    PR2 = 0x9b;
    // duty cycle = (CCPR1L:CCP1CON<5:4>)*Tosc*(TMR2 prescaler) = (0x0b*4 + 0b01) * 8탎 * 4 = 0.00144s ~= 1450탎
    CCPR1L = 0x0b;
    CCP1CONbits.DC1B = 0b01;
    // Demo????TAs??????Tosc?PR2??CCPR1L?CCP1CON????????????20ms??duty cycle?500탎?2400탎?
    return;
}