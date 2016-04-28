;
; AssemblerApplication1.asm
;
; Created: 4/26/2016 1:18:55 PM
; Author : jbanks2
;


; Replace with your application code
/*
 * AssemblerApplication1.asm
 *
 *  Created: 12/10/2014 1:55:46 PM
 *   Author: Jesse
 */

.include "tn85def.inc"

.equ    signal = pb3
.equ	power = pb4
.equ    copy1 = pb0
.equ    copy2 = pb1
.equ    copy3 = pb2
.equ	copymask = (1<<copy1)|(1<<copy2)|(1<<copy3)
.org 0
rjmp    reset

.org 20
reset:

start:
 ;port setup 
 ldi	r16,copymask
 out    ddrb,r16
 ldi	r17,(1<<signal)	//set pullup on input
 out	portb,r17
 
loop:
 sbis   pinb,signal       ;skip if pin 1
 rjmp   loop            ;wait till step is set.
 
 out	portb,r16
loop2:
 sbic   pinb,signal       ;skip if step signal to drops
 rjmp   loop2           ;loop until drop
 
 out	portb,r17
 rjmp   start           ;go to start
