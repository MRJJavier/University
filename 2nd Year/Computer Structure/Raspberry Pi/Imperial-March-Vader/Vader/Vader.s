.data
.include "notas.inc"
.include "vader.inc"
.include "inter.inc"

onoff:   .word 0
cuenled: .word 6
cuenson: .word 0
cuendur: .word 0
modo:    .word 0
secuen : .word 0b1000000000000000000000000000
		 .word 0b0000010000000000000000000000
		 .word 0b0000000000100000000000000000
		 .word 0b0000000000000000100000000000
		 .word 0b0000000000000000010000000000
		 .word 0b0000000000000000001000000000
.text
/* Agrego vectores de interrupción */
	ADDEXC 0x18, irq_handler
	ADDEXC 0x1c, fiq_handler
	
/*Modo SVC */
	mrs r0, cpsr
	mov r0, #0b11010011 @ Modo SVC, FIQ&IRQ desact
	msr spsr_cxsf, r0
	add r0,pc,#4
	msr ELR_hyp,r0
	eret

/* Inicializo la pila en modos FIQ, IRQ y SVC */
	mov r0, # 0b11010001 @ Modo FIQ, FIQ&IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x4000
	mov r0, # 0b11010010 @ Modo IRQ, FIQ&IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x8000
	mov r0, # 0b11010011 @ Modo SVC, FIQ&IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x8000000

/* Configuro GPIOs 4, 9, 10, 11, 17, 22 y 27 como salida */
	ldr r0, = GPBASE
/* guia bits    xx999888777666555444333222111000 */
	ldr r1, = 0b00001000000000000001000000000000
	str r1, [r0, # GPFSEL0 ]
	ldr r1, = 0b00000000001000000000000000001001
	str r1, [r0, # GPFSEL1 ]
	ldr r1, = 0b00000000001000000000000001000000
	str r1, [r0, # GPFSEL2 ]

/* Programo C1 y C3 para dentro de 2 microsegundos */
	ldr r0, = STBASE
	ldr r1, [r0, # STCLO ]
	add r1, #2
	str r1, [r0, # STC1 ]
	str r1, [r0, # STC3 ]

/* Habilito C3 para FIQ */
	ldr r0, = INTBASE
	ldr r1, = 0b10000011
	str r1, [r0, # INTFIQCON]

/* Habilito C1 para IRQ */
	mov r1, #0b0010
    str r1,[r0,#INTENIRQ1]

/* Habilito interrupciones globalmente */
	mov r0, # 0b00010011 @ Modo SVC, FIQ&IRQ activo
	msr cpsr_c, r0
	
/* Repetir para siempre */
	ldr r0, = GPBASE

	
/* guia bits       10987654321098765432109876543210*/
	mov   	r5, #0b00000000000000000000000000010000
	mov		r3, #0
	
bucle:	
	bl      espera        	@ Salta a rutina de espera
    str     r5, [r0, #GPSET0]	@ enciende buzzer 
    bl      espera        	@ Salta a rutina de espera
    str     r5, [r0, #GPCLR0]	@apaga buzzer  
    b     bucle

/* rutina que espera periodo de la nota*/
espera:	
	push	{r0 - r2, r4- r11}
	ldr    r1, [r0, #GPLEV0]
    ands    r2, r1, #0b00000000000000000000000000000100
    beq    pulsador1
    ands    r2, r1, #0b00000000000000000000000000001000
    beq    pulsador2
nota:
	ldr   	r0, =STBASE    	@ r0 es un parametro de periodo (dir. base ST)
    ldr     r4, [r0, #STCLO]	@ Lee contador en r4
    add   	r4, r3        	@ r4= r4 + periodo nota
ret1: 
	ldr    	r5, [r0, #STCLO]
    cmp  	r5, r4            	@ Leemos CLO hasta alcanzar
    blo    	ret1              	@ el valor de r4
	pop	{r0 - r2, r4- r11}
    bx     	lr

/* control de modo LEDs */
pulsador1:
	ldr r1, =modo
	mov r2, #0
	str r2, [r1]
	b	nota
	
pulsador2:
	ldr r1, =modo
	mov r2, #1
	str r2, [r1]
	b	nota	

/*Rutina de tratamiento de interrupción IRQ */
irq_handler :
	push {r0 - r11}
	ldr r0, = GPBASE
	ldr r1, = cuenled
	ldr r2, = modo
	ldr r3, = secuen
	ldr r4, = onoff
	
/* Apago LEDs   10987654321098765432109876543210 */
	ldr r5, = 0b00001000010000100000111000000000
	str r5, [r0, # GPCLR0 ]
/* Compruebo modo para ver si cambia la secuencia de LEDs */
	ldr r5, [r2] @ Leo variable modo
	cmp r5,#0
	beq sec1
	bne sec2

/* Todos los LEDs parpadean */
sec1:
	mov r5, #6
	str r5, [r1] @ Pongo cuenled a 6
	ldr r5, [r4] @ Leo variable
	eors r5, #1 @ Invierto bit 0, act. flag Z
	str r5, [r4] @ Escribo variable onoff
/* guia bits    10987654321098765432109876543210 */
	ldr r5, = 0b00001000010000100000111000000000
	streq r5, [r0, # GPSET0 ]
	strne r5, [r0, # GPCLR0 ]
	b	fin

/* Los LEDs se apagan y se encienden secuencialmente */
sec2:
	mov r5, #1
	str r5, [r4] @ Pongo onoff a 0
/* guia bits    10987654321098765432109876543210 */
	ldr r5, = 0b00001000010000100000111000000000
	str r5, [r0, # GPCLR0 ] @ Apago todos los LEDs
	ldr r5, [r1] @ Leo variable cuenta
	subs r5, #1 @ Decremento
	ldr r6, [r3, +r5, LSL #2] @ Leo secuencia
	str r6, [r0, # GPSET0 ] @ Escribo secuencia en LEDs
	moveq r5, #6 @ Si es 0, volver a 6
	str r5, [r1] @ Escribo cuenta
	b	fin
	
fin:
/* Reseteo estado interrupción de C1 */
	ldr r0, = STBASE
	mov r2, # 0b0010
	str r2, [r0, # STCS ]
/* Programo siguiente interrupción en 500ms */
	ldr r2, [r0, # STCLO ]
	ldr r1, = 500000 @ 2 Hz
	add r2, r1
	str r2, [r0, # STC1]
/* Recupero registros y salgo */
	pop {r0 - r11}
	subs pc, lr, #4

	
/* Rutina de tratamiento de interrupción FIQ */
fiq_handler :
	push	{r4- r7}
	ldr r4, =notaFS
	ldr r5, =duratFS
	ldr r6, =cuenson
	ldr r7, =cuendur
	ldr r8, =STBASE

/* Guardo en r3 la nota */
    ldr r9, [r6]
    ldr r3, [r4, + r9, LSL #2]
	add r9, #1
	cmp r9, #72
	moveq r9, #0
	str r9,[r6]
	
/* Saco la duracion de la nota */	
	ldr r9, [r7]
    ldr r10, [r5, + r9, LSL #2]
	add r9, #1
	cmp r9, #72
	moveq r9, #0
	str r9,[r7]

/* Reseteo estado interrupción de C3 */
	mov r11, # 0b1000
	str r11, [r8, # STCS ]

/* Programo retardo según valor leído en array */
	ldr r11, [r8, # STCLO ]
	add r11, r10
	str r11, [r8, # STC3 ]

/* Recupero registros y salgo de la RTI */
	pop	{r4- r7}
	subs pc, lr, #4
