#include "Lista.h"
#include <stdlib.h>
#include <stdio.h>

void crearLista(Lista *pl){

	*pl=NULL;
}
int listaVacia(Lista l){


	return l==NULL;
}
void insertarLista(Lista *pl,int elem){
	Lista aux = (Lista) malloc(sizeof(struct NodoLista));
	aux->valor=elem;
	Lista ant=NULL,act=*pl;
	while(act!=NULL && act->valor<elem){
		ant=act;
		act=act->sig;
	}
	if(ant==NULL){
		// o la lista esta vacia
		// o elem es menor que el primer elemento
		aux->sig = act;
		*pl=aux;
	}else{
		aux->sig=act;
		ant->sig=aux;
	}

}
int extraerLista(Lista *pl, int elem){

	return 0;
}
int estaElemento(Lista l,int elem){
	Lista aux = l;
	while(aux!=NULL && aux->valor<elem)
			aux = aux->sig;
	if(aux==NULL) return 0;
	if(aux->valor>elem) return 0;
	else return 1;

	return 0;
}
void recorrerLista(Lista l){
	printf("**** \n Lista: ");
	while(l!=NULL){
		printf("%d ",l->valor);
		l=l->sig;
	}
	printf("\n **** \n");
}
void borrarLista(Lista *pl){

}
