/*
 * Lista.h
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */
#ifndef LISTA_H_
#define LISTA_H_

struct NodoLista{
	int valor;
	struct NodoLista *sig;
};

typedef struct NodoLista *Lista;

void crearLista(Lista *pl);
int listaVacia(Lista l);
void insertarLista(Lista *pl,int elem);
int extraerLista(Lista *pl, int elem);
int estaElemento(Lista l,int elem);
void recorrerLista(Lista l);
void borrarLista(Lista *pl);


#endif /* LISTA_H_ */
