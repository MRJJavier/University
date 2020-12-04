/*
 * Persona.c
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */
#include "Persona.h"
#include <stdio.h>


void leerPersona(struct Persona * p){
	printf("Escribe el nombre y la edad: ");
	scanf("%s %d", p->nombre,&(p->edad));
}
void escribirPersona(struct Persona p){
	printf("Nombre: %s,\t Edad: %d",p.nombre,p.edad);
}
void leerListaPersona(struct Persona * lista, int l){
	for(int i=0;i<l;i++)
		leerPersona(lista+i);
}
void escribirListaPersona(struct Persona * lista, int l){
	for(int i=0;i<l;i++){
		escribirPersona(*(lista+i));
		printf("\n");
	}

}

//fflush(stdout) <-- sirve para limpiar el buffer


