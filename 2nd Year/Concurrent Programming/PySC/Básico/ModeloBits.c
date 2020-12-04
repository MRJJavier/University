#include <stdio.h>
/*
 * ModeloBits.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */

int main4(){
    int n=-8;
    printf("Int d: %d\n",n);
    printf("Int u: %u\n",n);
    char a;
    unsigned char b;
    a='A';
    b='B';
    printf("Char a: %c, Unsigned char b: %c, Num char a: %d, Num char b: %d\n",a,b,a,b);
    a=183;
    b=255;
    printf("Nuevo A: %d Nuevo B: %d\n",a,b); // -73 255
    int m= 0xC2ED400; // 1100 0010 1110 1101 0100 0000 0000 0000
    printf("Unsigned: %u\n",m);
    printf("Decimal: %d\n",m);
    printf("Hexadecimal sin 0x (original variable): %x\n",m);
    printf("Hexadecimal con 0x(original variable): %p\n",m);
    printf("Octal: %o\n",m);
    printf("Float: %f\n",*((float*)&m));
    printf("Tamaño char: %d\n",sizeof(char));
    printf("Tamaño int: %d\n",sizeof(int));
    printf("Tamaño float: %d\n", sizeof(float));
	printf("Tamaño double: %d\n",sizeof(double));
    return 0;

}








