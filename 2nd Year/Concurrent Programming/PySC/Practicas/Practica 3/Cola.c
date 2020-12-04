/*
 * Cola.c
 *
 *  Created on: 28 mar. 2019
 *      Author: José Javier Morente.
 */
#include <stdio.h>
#include <stdlib.h>
#include "Cola.h"

//Se crea la cola.
void crear(Cola *cola){
	cola->primero=NULL;
	cola->ultimo=NULL;
}
//Si la cola esta vacia, crea el un nodo que sera primero y ultimo a la vez y guarda el valor.
//Si la cola no esta vacia y el ultimo nodo no esta completo, lo completa.
//Si la cola no esta vacia y el ultimo nodo esta completo, crea uno nuevo que pasa a ser el ultimo.
void insertar(Cola *cola,unsigned *v){

	if(!colaVacia(*cola) && (cola->ultimo)->v[0]==NULL){
		(cola->ultimo)->v[0]=*v;
	}else{
		Puntero aux = (Puntero) malloc(sizeof(struct Nodo));
		aux->v[0]=NULL;
		aux->v[1]=*v;
		aux->sig=cola->ultimo;
		cola->ultimo=aux;
	}
	if(colaVacia(*cola)){
			Puntero aux = (Puntero) malloc(sizeof(struct Nodo));
			aux->v[0]=NULL;
			aux->v[1]=*v;
			aux->sig=NULL;
			cola->primero=aux;
			cola->ultimo=aux;
		}
}

//Si la cola esta vacia no hace nada.
//Si el nodo tiene primer elemento, se elimina.
//Si el nodo no tiene primer elemento, se elimina el segundo y se libera el nodo.
//Si se elimina el único nodo de la cola, la cola pasa a estar vacia.
int extraer(Cola *cola, unsigned *v){

	if(cola->primero!=NULL){
		Puntero aux=cola->ultimo;
		while(aux->sig!=cola->primero && aux->sig!=NULL){
			aux=aux->sig;
		}
		if((cola->primero)->v[1]!=NULL){
			*v=(cola->primero)->v[1];
			(cola->primero)->v[1]=NULL;
		}else{
			*v=(cola->primero)->v[0];
			(cola->primero)->v[0]=NULL;
			if(cola->ultimo != cola->primero){
				free(cola->primero);
				aux->sig=NULL;
				cola->primero=aux;
			}else{
				free(cola->primero);
				cola->primero=NULL;
				cola->ultimo=NULL;
			}
		}
		printf("He extraido %d\n",*v);
	}
	return 0;
}
//Devuelve si la cola esta o no vacia (1 o 0).
int colaVacia(Cola cola){
	return cola.primero == NULL;
}

//Muestra la cola, siendo el último nodo insertado el que se encuentre más a
//la izquierda y el primer nodo insertado el que se encuentre más a la derecha.
void recorrer(Cola cola){
	printf("Cola: [");
	while(cola.ultimo!=NULL){
		printf("[%d,%d]",cola.ultimo->v[0],cola.ultimo->v[1]);
		cola.ultimo=(cola.ultimo)->sig;
	}
	printf("]\n");
}
//Libera todos los nodos de la cola y la deja vacia.
void destruir(Cola *cola){
	Puntero aux;
	while(cola->ultimo!=NULL){
		aux=cola->ultimo;
		cola->ultimo=(cola->ultimo)->sig;
		free(aux);
	}
	cola->ultimo=NULL;
	cola->primero=NULL;

}
