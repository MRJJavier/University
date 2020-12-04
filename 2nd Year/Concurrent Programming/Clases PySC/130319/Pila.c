#include "Pila.h"
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

	*ppila=NULL;
}
void mostrarPila(Pila pila){
	/*Pila aux= pila;
	while (aux!=NULL){
		printf("%d \n",aux->valor);
		aux=aux->sig;
	}
	*/
	printf("*********************\n Pila: ");
	while (pila!=NULL){
		printf("%d ",pila->valor);
		pila=pila->sig;
	}
	printf("\n*********************\n");
}
void insertarPila(Pila* ppila, int elem){
	Pila aux = (Pila) malloc(sizeof(struct NodoPila));
	aux->valor = elem;
	aux->sig= *ppila;
	*ppila= aux;

}


int extraerPila(Pila* ppila, int *elem){
	Pila aux = *ppila;
	if(pilaVacia(aux)){
		return -1;
	}
	*elem = (aux)->valor; //(*(*ppila)).valor
	//*elem = ppila->valor; *elem = (*ppila).valor
	*ppila = aux->sig;
	free(aux);
	return 0;
}

int pilaVacia(Pila pila){

	return pila == NULL;
}
void borrarPila(Pila *ppila){
	Pila aux;
	while(!pilaVacia(*ppila)){
		aux= *ppila;
		*ppila = (*ppila)->sig; //*ppila= *(*ppila).sig // *ppila = aux->sig;
		free(aux);
	}
}

#endif /* PILA_C_ */
