/*
 * Lista.c
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */
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
	Lista aux = (Lista)malloc(sizeof(struct NodoLista));
	aux->valor=elem;
	Lista ant,act;
	ant=NULL;
	act=*pl;
	while(act!=NULL && act->valor<elem)
		ant=act;
		act=act->sig;
	if(ant==NULL){
		aux->sig=act;
		*pl=aux;
	}else{
		aux->sig=act;
		ant->sig=aux;
	}
}
int extraerLista(Lista *pl, int elem){
	Lista ant,act;
	ant=NULL;
	act=*pl;
	while(act!=NULL && act->valor<elem){
		ant=act;
		act=act->sig;
	}
	if(act==NULL || act->valor>elem){
		return -1;
	}else{
		if(ant==NULL){
			*pl=act->sig;
		}else{
			ant->sig=act->sig;
		}
		free(act);
		return 0;
	}
}
int estaElemento(Lista l,int elem){
	while(l!=NULL && l->valor<elem)
		l=l->sig;
	if(l==NULL) return 0;
	if(l->valor>elem) return 0;
	else return 1;
}
void recorrerLista(Lista l){
	printf("Lista: ");
	while(l!=NULL){
		printf("%d ",l->valor);
		l=l->sig;
	}
	printf("\n");
}
void borrarLista(Lista *pl){
	Lista aux;
	while(*pl!=NULL){
		aux=*pl;
		*pl=(*pl)->sig;
		free(aux);
	}
}
