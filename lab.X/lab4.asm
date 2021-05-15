LIST p = 18f4520
#include <p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF

	org 0x00

Initial:
    movlf macro literal,F
	movlw literal ;move literal to WREG
	movwf F, 0 ;move value in WREG to F
	clrf WREG
	endm
    addfff macro f1,f2,f_res
	movf f1 , 0;move value in f1 to WREG
	addwf f2, 0, 0 ;add f2 and WREG, store result in WREG
	movwf f_res ;move value in WREG to f_res
	clrf WREG
	endm
Start:
    movlf 0, 0x11
    movlf 1, 0x12
    movlf 5, 0x13
    rcall fib
    nop
    rcall finish
fib:
    movf 0x11, 0;move value in 0x11 to WREG
    movwf 0x10 ;move value in WREG to 0x10
    movf 0x12, 0;move value in 0x12 to WREG
    movwf 0x11 ;move value in WREG to 0x11    
    addfff 0x10, 0x11, 0x12
    dcfsnz 0x13, 1
	return
    movlw 0x18
    movwf PCL
finish:    
    END


