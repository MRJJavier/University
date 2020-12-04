/*
 * Pila.c
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */

#include "Pila.h"
#include <stdlib.h>
#include <stdio.h>

void crearPila(Pila * ppila){
	*ppila=NULL;
}
void mostrarPila(Pila pila){
	printf("Pila: ");
	while(pila!=NULL){
		printf("%d",pila->valor);
		pila=pila->sig;
	}
	printf("\n");
}
void insertarPila(Pila* ppila, int elem){
	Pila aux = (Pila)malloc(sizeof(struct NodoPila));
	aux->valor=elem;
	aux->sig=*ppila;
	*ppila=aux;
}
int extraerPila(Pila* ppila, int *elem){
	Pila aux= *ppila;
	if(pilaVacia(aux)){
		return -1;
	}
	*elem=aux->valor;
	*ppila=aux->sig;
	free(aux);
	return 0;
}
int pilaVacia(Pila pila){
	return pila==NULL;
}
void borrarPila(Pila *ppila){
	Pila aux;
	while(!pilaVacia(*ppila)){
		aux=*ppila;
		*ppila=aux->sig;
		free(aux);
	}
}
