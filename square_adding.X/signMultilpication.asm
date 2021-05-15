include<p18f4520.inc>
org 0x100
    
    clrf wreg
    clrf 0x01  ;store sign of 0x15
    clrf 0x02  ;store sogn of 0x17
    movlw 0xFE
    movwf 0x15
    movlw 0xFC
    movwf 0x17
    
    btfss 0x15,7  ;if bit7 = 1,skip
    bra checkNum2
    negf 0x15,F
    addwf 0x01,1
    
checkNum2:
    btfss 0x17,7  ; if bit7=1, skip
    bra doJob
    negf 0x17,F
    addwf 0x02,1

doJob:
    movf 0x15,wreg
    mulwf 0x17
    movf 0x01,wreg
    xorwf 0x02,F
    btfss 0x02,1  ;if bit1 = 1, skip
    bra finish
    
    comf prodl  ;take 2's of num
    comf prodh  ;take 2's of num
    movlw 1     ;convert to 2;s complement need to +1
    addwf prodl
    movlw 0
    addwfc prodh  ;ans store in prodh
    
finish:
    end
