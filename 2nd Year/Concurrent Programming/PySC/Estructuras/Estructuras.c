/*
 * Estructuras.c
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */
#include "Persona.h"
#include "Pila.h"
#include "Lista.h"
#include <stdio.h>

int main18(){
	unsigned n;
	printf("Inserte el número de personas que quiere insertar: ");
	scanf("%d",&n);
	struct Persona p, lista[n-1];
	if(n==0){
		printf("No se va a insertar ninguna persona.");
	}else{
		if(n==1){
				leerPersona(&p);
				escribirPersona(p);
			}else{
				leerListaPersona(lista,n);
				escribirListaPersona(lista,n);
			}
	}
	return 0;
}

int main19(){


	return 0;
}

int main20(){
	return 0;
}

