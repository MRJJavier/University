/*#include "Pila.h"
#include <stdlib.h>
#include <stdio.h>

#ifndef PILA_C_
#define PILA_C_

void crearPila(Pila * ppila){
	//crea una pila vacia

	/*  *pila=(Pila)malloc(sizeof(struct NodoPila));
	 *
	 *  Esto no se puede hacer porque guarda una memoria
	 *  y despues nos olvidamos de la direccion al poner
	 *  *pila=NULL. Es ineficiente.
	 */
/*
	*ppila=NULL;
}
void mostrarPila(Pila pila){
	/*Pila aux= pila;
	while (aux!=NULL){
		printf("%d \n",aux->valor);
		aux=aux->sig;
	}
	*/
/*	while (pila!=NULL){
		printf("%d \n",pila->valor);
		pila=pila->sig;
	}
}
void insertarPila(Pila* ppila, int elem){
	Pila aux = (Pila) malloc(sizeof(struct NodoPila));
	aux->valor = elem;
	aux->sig= *ppila;
	*ppila= aux;

}
int extraerPila(Pila* ppila, int *elem){
	if(pilaVacia(*ppila)){
		return -1;
	}
	*elem = (*ppila)->valor; //(*(*pila)).valor
	//*elem = pila->valor; *elem = (*pila).valor
	return 0;

}
int pilaVacia(Pila pila){

	return pila == NULL;
}
void borrarPila(Pila *ppila){
	Pila aux;
	while(!pilaVacia(*ppila)){
		aux= *ppila;
		*ppila = (*ppila)->sig; //*pila= *(*pila).sig
		free(aux);
	}
}

#endif /* PILA_C_ */
