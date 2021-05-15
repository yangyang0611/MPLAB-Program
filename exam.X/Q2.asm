LIST p = 18f4520
#include <p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF

	org 0x00
	
start:
    clrf WREG
    CLRF 0x00
    movlw 0x83 ; WREG = 83(HIGH)
    addwf 0x00,1,0
    
    clrf WREG
    clrf 0x01
    movlw 0x45
    addwf 0x01,1,0
    
    clrf WREG
    clrf 0x02
    movlw 0x81 ; WREG = 81(HIGH)
    addwf 0x02,1,0
    
    clrf WREG
    movlw 0x47
    clrf 0x03
    addwf 0x03,1,0
    
    clrf wreg
    
step1:
    movf 0x03
    mulwf 0x01
    movff PRODL, 0x07
    movff PRODH, 0x06
    
    clrf PRODL
    CLRF PRODH
    
    movf 0x02
    mulwf 0x00
    movff PRODL, 0x05
    movff PRODH, 0x04
    
    movf 0x02 ;low first * high sec
    mulwf 0x01 ;store result in wreg
    addwf 0x06,F ; add result to 0x06
    addwfc 0x05,F;  add result and acarry to 0x05
    
    movf 0x03
    mulwf 0x00
    addwf 0x06,F
    addwfc 0x05,F
    
    
step2:
    movff 0x02,WREG
    btfsc 0x00,7 ; if bit7=1,do next
    subwf PRODH,F
    
    movff 0x03,WREG
    btfsc 0x00,7 ; if bit7=1,do next
    subwf PRODL,F
    
step3:
    movff 0x00,WREG
    btfsc 0x02,7 ; if bit7=1,do next
    subwf PRODH,F
    
    movff 0x01,WREG
    btfsc 0x02,7 ; if bit7=1,do next
    subwf PRODL,F



   
end