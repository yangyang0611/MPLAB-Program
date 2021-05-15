#include<p18f4520.inc>
    org 0x00
    
start:
    lfsr FSR0,0x0100   
    clrf TRISC
    lfsr FSR1,0x0118 
    movlw 0x00
  
loop:
    movwf INDF0 ;use fsr0 as address and move wreg's data into it
    addwf TRISC,1
    addlw 1
    btfss POSTINC0,3
    goto loop
    
    
    movff TRISC,WREG
loop2:
    movwf POSTDEC1;use fsr1 as address and move wreg's data into it.then decrease it 
    decf FSR0L ;8
    subfwb FSR0L,0 ;wreg-fsr0
    btfsc FSR1L,4   
    goto loop2
    
end