#ifndef LISTA_H_
#define LISTA_H_

typedef struct NodoLista *Lista;

struct NodoLista{
	int valor;
	Lista sig;
};


void crearLista(Lista *pl);
int listaVacia(Lista l);
void insertarLista(Lista *pl,int elem);
int extraerLista(Lista *pl, int elem);
int estaElemento(Lista l,int elem);
void recorrerLista(Lista l);
void borrarLista(Lista *pl);

#endif /* LISTA_H_ */
