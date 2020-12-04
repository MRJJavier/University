        .include  "inter.inc"
.text
/* Agrego vector interrupcion */
        ADDEXC  0x18, irq_handler

/*Modo SVC */
	mrs r0, cpsr
	mov r0, #0b11010011 @ Modo SVC, FIQ&IRQ desact
	msr spsr_cxsf, r0
	add r0,pc,#4
	msr ELR_hyp,r0
	eret

/* Inicializo la pila en modos IRQ y SVC */
        mov     r0, #0b11010010   @ Modo IRQ, FIQ&IRQ desact
        msr     cpsr_c, r0
        mov     sp, #0x8000
        mov     r0, #0b11010011   @ Modo SVC, FIQ&IRQ desact
        msr     cpsr_c, r0
        mov     sp, #0x8000000

/* Configuro GPIOs 22,27 como salida */
        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
        ldr     r1, =0b00000000001000000000000001000000
        str     r1, [r0, #GPFSEL2]
/* guia bits           10987654321098765432109876543210*/
        ldr  	r1, =0b00001000010000000000000000000000
		str		r1, [r0,#GPSET0]

/* Habilito pines GPIO 2,3 (boton) para interrupciones*/
/* guia bits           10987654321098765432109876543210*/
        mov     r1, #0b00000000000000000000000000001100
        str     r1, [r0, #GPFEN0]
        ldr     r0, =INTBASE

/* Habilito interrupciones, local y globalmente */
        mov     r1, #0b00000000000100000000000000000000
/* guia bits           10987654321098765432109876543210*/
        str     r1, [r0, #INTENIRQ2]
        mov     r0, #0b01010011   @ Modo SVC, IRQ activo
        msr     cpsr_c, r0

/* Repetir para siempre */
bucle:  b       bucle

/* Rutina de tratamiento de interrupcion */
irq_handler:
        push    {r0, r1, r2}
        ldr     r0, =GPBASE
		/* guia bits   10987654321098765432109876543210*/
        ldr  	r1, =0b00001000010000000000000000000000
		str		r1, [r0,#GPCLR0]
		
		ldr		r1, [r0,#GPEDS0]
/* guia bits           10987654321098765432109876543210*/
		ands	r1, #0b00000000000000000000000000000100
		movne   r1, #0b00000000010000000000000000000000
		moveq   r1, #0b00001000000000000000000000000000
		str		r1, [r0,#GPSET0]

	
/* Desactivo el flag GPIO pendiente de atencion
   guia bits               54321098765432109876543210*/
        mov   r1, #0b00000000000000000000000000001100	
		str   r1, [r0, #GPEDS0]
		
/* Habilito pines GPIO 2,3 (boton) para interrupciones*/
/* guia bits           10987654321098765432109876543210*/
        mov     r1, #0b00000000000000000000000000001100
        str     r1, [r0, #GPFEN0]
   
fin:	pop     {r0, r1, r2}
        subs    pc, lr, #4
