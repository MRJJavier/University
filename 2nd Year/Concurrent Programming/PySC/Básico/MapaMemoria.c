/*
 * MapaMemoria.c
 *
 *  Created on: 7 mar. 2019
 *      Author: José Javier Morente
 */


#include <stdio.h>

int main5(int argc,char ** args){
	char a,b,c;
	a = 7;
	b = -13;
	c = 0;
	printf("nombre variable char: %c, \t direccion memoria hexadecimal con 0x:%p, \tvalor:%d\n",'a',&a,a);
	printf("nombre variable char: %c, \t direccion memoria hexadecimal con 0x:%p, \tvalor:%d\n",'b',&b,b);
	printf("nombre variable char: %c, \t direccion memoria hexadecimal con 0x:%p, \tvalor:%d\n",'c',&c,c);
	return 0;
}
int main6(int argc,char ** args){
	char a;
	int b;
	float f;
	double d;
	a = 7;
	b = -13;
	f = 0.1;
	d = 42.5;

	printf("nombre variable char: %c, \t direccion memoria decimal:%d, \tvalor:%d\n",'a',&a,a);
	printf("nombre variable int: %c, \t direccion memoria decimal:%d, \tvalor:%d\n",'b',&b,b);
	printf("nombre variable float: %c, \t direccion memoria decimal:%d, \tvalor:%f\n",'f',&f,f);
	printf("nombre variable double: %c, \t direccion memoria decimal:%d, \tvalor:%lf\n",'d',&d,d);
	return 0;
}

int main7(int argc,char ** args){
	char a;
	short int b;
	char c;
	a = 6;
	b = 13;
	c = '6';
	printf("nombre variable char: %c, \t direccion memoria decimal:%d, \tdecimal:%d, octal:%x\n",'a',&a,a,a);
	//0000 0110
	printf("nombre variable short int: %c, \t direccion memoria decimal:%d, \tdecimal:%d, octal:%x\n",'b',&b,b,b);
	//0000 0000 0000 1101
	printf("nombre variable char: %c, \t direccion memoria decimal:%d, \tdecimal:%c, octal:%x\n",'c',&c,c,c);
	//0011 0110
    return 0;
}
