#include<p18f4520.inc>
    org 0x00
 
start:
    clrf WREG
    clrf LATA
    clrf LATB
    
NAND:
	movlw B'11011111'
	andlw B'10011110'
	xorlw B'11111111'
	movwf LATA

NOR:
    
	movlw B'01011011'
	iorlw B'11000100'
	xorlw B'11111111'
	movwf LATB

	

end