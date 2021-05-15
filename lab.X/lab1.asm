LIST p = 18f4520
#include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	
Initial:
    
start:
	clrf WREG
	clrf TRISC

	movlw 0x0f
	addwf TRISC,1
	decf TRISC
loop:
    addwf TRISC,0 ; save in working reg
    decfsz TRISC ; TRISC value-1
    goto loop
    
end 