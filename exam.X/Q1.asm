LIST p = 18f4520
#include <p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF

	org 0x00

	
Initial:
    INITIALIZE macro literal,a,b,c,d
	movlw literal
	movwf F,0
	clrf WREG
	endm
	
Start:
    clrf WREG
    lfsr FSR0, 0x100
    movlw D'4'
    movwf 0x120
    clrf WREG
    ;lfsr FSR1, 0x110
    
    
    INITIALIZE 0xD5,0xF4,,0x64,0x6F,0x87
    btfss POSTINC0,1 ; If bit 1=1, skip next inc
    
    INITIALIZE 0xF4,INDF0
    btfss POSTINC0,1
    
    INITIALIZE 0x64,INDF0
    btfss POSTINC0,1 
    
    INITIALIZE 0x6F,INDF0
    btfsc POSTINC0,3 ;if bit 3 = 0, skip next inc
    
    INITIALIZE 0x87,INDF0
    
    rcall SORTING
    nop
    rcall finish

SORTING:
    
    
    
finish:
    END