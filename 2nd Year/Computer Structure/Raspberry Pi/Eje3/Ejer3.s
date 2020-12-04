        .set    GPBASE,   0x3F200000
        .set    GPFSEL1,  0x04
        .set    GPSET0,   0x1c
        .set    GPCLR0,   0x28
.text
/* se enciende y se apaga el led, pero lo hace tan rápido que es imperfectible */
        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
        mov     r1, #0b00000000001000000000000000000000
        str     r1, [r0, #GPFSEL1]  @ Configura como salidas GPIO17
bucle:  
/* guia bits           10987654321098765432109876543210*/
        mov     r1, #0b00000000000000100000000000000000
        str     r1, [r0, #GPSET0]   @ Enciende GPIO17
        mov     r1, #0b00000000000000100000000000000000
        str     r1, [r0, #GPCLR0]   @ Apaga GPIO17
        b       bucle
