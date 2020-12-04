/*
 * Lista.h
 *
 *  Created on: 21 abr. 2019
 *      Author: jj
 */

#ifndef LISTA_H_
#define LISTA_H_

typedef struct Nodo *TLista;
struct Nodo{
	struct Punto *p;
	struct Nodo *sig;
};
struct Punto {
float x;
float y;
};


//Inicializa la lista de puntos creando una lista vacía
void crearLista(TLista *lista);
//Inserta el punto de forma ordenada (por el valor de la abscisa x) en la lista siempre que no
//esté repetida la abscisa. En ok, se devolverá un 1 si se ha podido insertar, y un 0 si no se pudo
//insertar. Nota: utiliza una función auxiliar para saber si ya hay un punto en la lista con la
//misma abscisa punto.x
void insertarPunto(TLista *lista, struct Punto punto, int *ok);
//Elimina de la lista el punto con abscisa x de la lista. En ok devolverá un 1 si se ha podido
//eliminar, y un 0 si no se pudo eliminar porque no existiera ese punto
void eliminarPunto(TLista *lista, float x, int *ok);
//Muestra en pantalla el listado de puntos
void mostrar_lista(TLista lista);
//Destruye la lista de puntos, liberando todos los nodos de la misma de memoria.
void destruir(TLista *lista);
//Lee el contenido del archivo binario de nombre nFichero, que contiene una secuencia de
//puntos de una función polinómica, y lo inserta en la lista.
void leePuntos(TLista *lista,char * nFichero);

#endif /* LISTA_H_ */
