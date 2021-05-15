INCLUDE<p18f4520.inc>
ORG 0x50
    
    clrf wreg
    clrf stkptr
    movlw 0x7E
    movwf 0x40
    movlw 0x08
    movwf 0x41
    movlw 0x23
    movwf 0x42
    movlw 0x30
    movwf 0x43
    
    movlw 0x05
    movwf stkptr
    lfsr 0,0x40
    call sqr
    bcf status,c
    rrcf 0x21,F
    bcf status,c
    rrcf 0x20,F
finish:
    goto finish
    
ORG 0x100
sqr:
    movlw 0x00
    movwf 0x20  ;lower bit
    movlw 0x21  ;upper bit
    movlw 0x04  ;counter = 4
    movwf 0x60

back:
    clrf 0x50  ;clear 0x50 reg
    movff indf0,0x50
    movff postinc0,wreg
    mulwf 0x50
    movf prodl,wreg
    addwf 0x20,F
    movf prodh,wreg
    addwf 0x21,F
    addwfc 0x21,F  ;deal with carry bits
    decfsz 0x60    ;skip if result = 0
    GOTO back
    Return
    end