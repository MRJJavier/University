/*
 * Invierte.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */

#include <stdio.h>
#include <string.h>

void invierte(char * palabra){
	int l = strlen(palabra);
	char aux;
	char *ini,*fin;
	ini = palabra;
	fin = ini + l-1;
	for(int i=0;i<l/2;i++){
		aux=*ini;
		*ini=*fin;
		*fin=aux;
		ini++;
		fin--;
	}

}

int main17(){
	char cadena[30];
	printf("Introduzca una palabra: ");
	scanf("%s",cadena);
	invierte(cadena);
	printf("La palabra invertida es: %s",cadena);
	return 0;
}
