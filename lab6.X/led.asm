#include "p18f4520.inc"

    CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  PBADEN = OFF           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
    
    cnt_i set 0x14
    cnt_j set 0x15
 
    org 0x00
    goto start
    
    delay macro num_out, num_in ;2+(2+(5+3)*100+5+3+3)*153+(2+(5+3)*100+5+3+3)
	local outerloop
	local innerloop
	movlw num_out
	movwf cnt_i
	outerloop:
	    movlw num_in
	    movwf cnt_j
	innerloop:
	    NOP ;1 cycle
	    NOP
	    NOP
	    NOP
	    NOP
	    NOP
	    NOP
	    decfsz cnt_j, 1, 0 ;1 cycle
	    bra innerloop ;2 cycles total 10 instruction cycles/loop
	    decfsz cnt_i, 1, 0
	    bra outerloop
	    ;0.5 second >> 12500 instructions cycles
	    ;10  instruction cycle/loop >> 12500 loops
	    ;use delay d'50' d'250'
    endm
    
    start:
    init:
	movlw b'00010000' 
	movwf TRISA ;RA4 control button
	clrf PORTA
	clrf TRISD ; set PORTD as output
	clrf LATD ; 0000 0000 , RD0~RD7 = 0
	clrf TRISB ; temp store LATD
    
    s1:
	btfsc PORTA, 4 ;if button is not pressed, loop
	    goto s1
	btfsc TRISB, 3
	    clrf TRISB
	btfsc TRISB, 0
	    rlncf TRISB
	bsf TRISB, 0
	movff TRISB, LATD
	delay d'50', d'250'
	clrf LATD ;clear 
	clrf PORTA
	goto s1
    end


