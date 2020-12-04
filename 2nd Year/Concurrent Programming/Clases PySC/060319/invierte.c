#include <stdio.h>
#include <string.h>

void invierte(char* palabra){
	int l = strlen(palabra);
	char aux;
	char* inic = palabra;
	char* fin =inic + l-1;
	for(int i=0; i<1/2; i++){
		aux=*inic;
		*inic=*fin;
		*fin=aux;
		inic++;
		fin--;
	}
}


