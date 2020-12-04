#include "Pila.h"
#include <stdio.h>

int main33(){

	Pila pila;
	int elem;
	crearPila(&pila);
	for(int i=0; i<10;i++){
		insertarPila(&pila,i);
	}
	mostrarPila(pila);
	while(!pilaVacia(pila)){
		extraerPila(&pila,&elem);
		mostrarPila(pila);
	}
	return 0;
}
