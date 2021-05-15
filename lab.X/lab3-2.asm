#include<p18f4520.inc>
    org 0x00

start:
    clrf WREG
    clrf TRISA
    clrf TRISB
    clrf TRISC
    clrf TRISD

    movlw 0x0D
    movwf TRISB,0 ; multiplicant
    clrf WREG
    
    movlw 0x0D
    movwf TRISC,0 ; multiplier
    clrf WREG
    
    movlw 0x04
    movwf TRISD,4
    clrf WREG
    
loop:
    btfsc TRISC, 0 ; id TRISC bit0 = 0, skip next
    addwf TRISB, 0, 0 ; no need to sum up
    rlncf TRISB, 1
    rrncf TRISC, 1
    
    decf TRISD
    bnz loop
    movwf TRISA
    
end


