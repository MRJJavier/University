    .set    GPBASE,   0x3F200000
    .set    GPFSEL0,        0x00
    .set    GPFSEL1,        0x04
    .set    GPSET0,         0x1c
    .set    GPCLR0,         0x28
    .set    GPLEV0,         0x34
	.set    STBASE,   0x3F003000
    .set    STCLO,          0x04
 
.text    
	
	
	mrs r0, cpsr
	mov r0, #0b11010011 @ Modo SVC, FIQ&IRQ desact
	msr spsr_cxsf, r0
	add r0,pc,#4
	msr ELR_hyp,r0
	eret
	mov sp, #0x08000000


        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
        ldr     r1, =0b00000000001000000000000000000000        
        str    r1, [r0, #GPFSEL1]  @ Configura GPIO 17
/* guia bits           xx999888777666555444333222111000*/
        ldr   	r1, =0b00001000000000000001000000000000
        str   	r1, [r0, #GPFSEL0]  @ Configura GPIO 4,9

pulsador:
    ldr    r1, [r0, #GPLEV0]
    ands    r2, r1, #0b00000000000000000000000000000100
    beq    pulsador1
    ands    r2, r1, #0b00000000000000000000000000001000
    beq    pulsador2
	b pulsador
 

pulsador1:    
/* guia bits             10987654321098765432109876543210*/
        mov       r1, #0b00000000000000000000001000000000
        str     r1, [r0, #GPSET0]   @ Enciende GPIO 9

		ldr	r1, =3816	@ r1 es un parametro de espera (microsec.)
		
	b     sound

pulsador2:
/* guia bits             10987654321098765432109876543210*/
        mov       r1, #0b00000000000000100000000000000000
        str     r1, [r0, #GPSET0]   @ Enciende GPIO 17
		
		ldr	r1, =2557	@ r1 es un parametro de espera (microsec.)
	
	b sound
	
sound:	
/* guia bits           10987654321098765432109876543210*/
        mov   	r5, #0b00000000000000000000000000010000
        ldr   	r2, =STBASE    	@ r0 es un parametro de periodo (dir. base ST)
bucle:	
        bl      espera        	@ Salta a rutina de espera
        str     r5, [r0, #GPSET0]	@ enciende buzzer
        bl      espera        	@ Salta a rutina de espera
        str     r5, [r0, #GPCLR0]	@apaga buzzer
        b       bucle		
		
    b     bucle
	

espera:	
	push	{r4,r5}
        ldr     r4, [r2, #STCLO]	@ Lee contador en r4
        add   	r4, r1            	@ r4= r4 + periodo
ret1: 	ldr    	r5, [r2, #STCLO]
        cmp  	r5, r4            	@ Leemos CLO hasta alcanzar
        blo    	ret1              	@ el valor de r4
	pop	{r4,r5}
        bx     	lr
