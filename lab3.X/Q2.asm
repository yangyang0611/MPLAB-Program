#include<p18f4520.inc>
    org 0x00

start:
    clrf WREG
    clrf TRISA
    clrf TRISB
    clrf TRISC
    clrf TRISD

    movlw 0x0D
    movwf TRISB,0
    clrf WREG
    
    movlw 0x0D
    movwf TRISC,0
    clrf WREG
    
    movlw 0x04
    movwf TRISD,4
    clrf WREG
    
loop:
    btfsc TRISC, 0
    addwf TRISB, 0, 0
    rlncf TRISB, 1
    rrncf TRISC, 1
    
    decf TRISD
    bnz loop
    movwf TRISA
    
end