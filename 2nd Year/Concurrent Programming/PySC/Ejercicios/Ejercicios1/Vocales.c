/*
 * Vocales.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */

#include <stdio.h>
#include <string.h>


int esVocal(char c){
	char vocales[10]={'a','e','i','o','u','A','E','I','O','U'};
	int es=0;
	for(int i=0;i<sizeof(vocales);i++){
		if(c==vocales[i]){
			es++;
		}
	}
	return 1<=es;
}

int nVocales(char *str){
	int nVocal=0;
	char *ptr=str;
	while ( *ptr != '\0'){
		if(esVocal(*ptr)){
			nVocal++;
		}
		ptr++;
	}

	return nVocal;
}



int main15(){
	char cadena[30];
	printf("Introduce una palabra: ");
	scanf("%s",cadena);
	printf("La palabra %s tiene %d vocales",cadena,nVocales(cadena));
	return 0;
}
