        .include  "inter.inc"
		onoff: .word 0
		
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

/* Configuro GPIO 9,10,11,17,22,27 como salida */
        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
        ldr     r1, =0b00001000000000000000000000000000
        str     r1, [r0, #GPFSEL0]
/* guia bits           xx999888777666555444333222111000*/
        ldr     r1, =0b00000000001000000000000000001001
        str     r1, [r0, #GPFSEL1]
/* guia bits           xx999888777666555444333222111000*/
        ldr     r1, =0b00000000001000000000000001000000
        str     r1, [r0, #GPFSEL2]

/* Programo contador C1 para futura interrupcion */
        ldr     r0, =STBASE
        ldr     r1, [r0, #STCLO]
        add     r1, #0x004000   @medio segundo
        str     r1, [r0, #STC1]

/* Habilito interrupciones, local y globalmente */
        ldr     r0, =INTBASE
        mov     r1, #0b0010
        str     r1, [r0, #INTENIRQ1]
        mov     r0, #0b01010011   @ Modo SVC, IRQ activo
        msr     cpsr_c, r0
		
/* Repetir para siempre */
bucle:  b       bucle

/* Rutina de tratamiento de interrupción */
irq_handler:
        push    {r0 - r5}          @ Salvo registros	
        ldr     r0, =GPBASE
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00000000000000000000001000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00000000000000000000010000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera	
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00000000000000000000100000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00000000000000100000000000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera	
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00000000010000000000000000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera		
/* guia bits           10987654321098765432109876543210*/
        ldr     r1, =0b00001000000000000000000000000000
        str     r1, [r0, #GPSET0] @ Enciendo LED
		bl		espera
		str     r1, [r0, #GPCLR0] @ Apago LED
		bl		espera
		ldr     r0, =STBASE
		mov     r1, #0b0010
		str     r1, [r0,#STCS]
        ldr     r1, [r0, #STCLO]
        add     r1, #0x004000    @medio segundo
        str     r1, [r0, #STC1]
        pop     {r0 - r5}          @ Recupero registros
        subs    pc, lr, #4        @ Salgo de la RTI
		
espera:	
	push	{r1,r2,r4,r5}
		ldr   	r2, =STBASE    	@ r0 es un parametro de periodo (dir. base ST)
		ldr     r1, =0x004000
        ldr     r4, [r2, #STCLO]	@ Lee contador en r4
        add   	r4, r1            	@ r4= r4 + periodo
ret1: 	ldr    	r5, [r2, #STCLO]
        cmp  	r5, r4            	@ Leemos CLO hasta alcanzar
        blo    	ret1              	@ el valor de r4
	pop	{r1,r2,r4,r5}
        bx     	lr
