#include "p18f4520.inc"

  CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  PBADEN = OFF           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  org 0x00
    
    init:
    CLRF    TRISD	; set PORTD as output
    CLRF    LATD	; 0000 0000 , RD0~RD7 = 0
    
    s1:
    INCF    LATD	; 0000 0001 , RD0 = 1, turn on RD0
    NOP
    
    end


