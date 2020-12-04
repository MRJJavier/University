/*
 * TiposBasicos.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */


#include <stdio.h>

int main2(){

	//Todas las variables son, por defecto, signed.

	int i=5;
	short int si=2; // short int = short
	long int li=-53; // long int = long
	unsigned int ui=4;
	unsigned short int usi=2;
	unsigned long int uli=776;
	char c='H';
	char s[3]="Hi!";
	signed char sc='i';
	unsigned char uc='!';
	float f=54.123456789;
	double d=54.123456789;
	long double ld=-54.123456789;

	printf("Int: %i, Int: %d \n",i,i);
	printf("Short int: %hi \n",si);
	printf("Long int: %li \n",li);
	printf("Unsigned int: %u \n",ui);
	printf("Unsigned short int: %hu \n",usi);
	printf("Unsigned long int: %lu \n",uli);
	printf("Char: %c \n",c);
	printf("String: %s \n",s);
	printf("Signed char: %c, Signed char numerical output: %hhi \n",sc,sc);
	printf("Unsigned char %c, Unsigned char numerical output: %hhu \n",uc,uc);
	printf("Float digital notation: %f, Float scientific notation %e\n",f,f);
	printf("Double: %lf \n",d);
	printf("Long double %Lf \n",ld);

	/* Todos los tipos posibles para Float:
	 * %f %F %g %G %e %E %a %A
	 * Todos los tipos posibles para Double:
	 * %lf %lF %lg %lG %le %lE %la %lA
	 * Todos los tipos posibles para Long double:
	 * %Lf %LF %Lg %LG %Le %LE %La %LA
	 */

	return 0;
}
