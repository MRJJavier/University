/*
 * Pila.h
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */

#ifndef PILA_H_
#define PILA_H_

struct NodoPila{
	int valor;
	struct NodoPila *sig;
};

typedef struct NodoPila* Pila; //Se renombre la esctructura. Pila = Puntero a struct NodoPila

void crearPila(Pila * ppila); //crea una pila vacia
void mostrarPila(Pila pila);
void insertarPila(Pila* ppila, int elem);
int extraerPila(Pila* ppila, int *elem);
int pilaVacia(Pila pila);
void borrarPila(Pila *ppila); //eliminar todos los elementos
							 //y dejar la pila vacia

#endif /* PILA_H_ */
