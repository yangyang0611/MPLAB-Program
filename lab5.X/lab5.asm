#include "xc.inc"
    
    GLOBAL _divide
    
    PSECT mytext, local, class=CODE, reloc=2
 
 _divide:
    clrf TRISB
    movlw 0x08
    movwf TRISB
    clrf WREG
    movff 0x001, LATB
    movff 0x002, LATC
    movf 0x003,W
    rcall shift
compare:
    cpfslt LATC  //compare to wreg ,if < :skip
    goto sub
clear:
    rcall shift
    bcf LATB,0
    goto loop
   
sub:
     subwf LATC,F
     rcall shift
     bsf LATB,0
     
loop:
     decfsz TRISB,F
     goto compare
     goto Finish
shift:
    rlcf LATB,F
    rlcf LATC,F
    return
     
Finish:
    rrncf LATC,F
    bcf LATC,7
    movff LATB,0x001  
    movff LATC,0x002
    movff WREG,0x003
    return