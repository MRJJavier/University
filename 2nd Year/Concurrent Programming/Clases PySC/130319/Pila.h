
#ifndef PILA_H_
#define PILA_H_

typedef struct NodoPila* Pila; //Se renombra la estructura Pila = puntero a struct NodoPila

struct NodoPila{
	int valor;
	struct NodoPila *sig;
};

void crearPila(Pila * ppila); //crea una pila vacia
void mostrarPila(Pila pila);
void insertarPila(Pila* ppila, int elem);
int extraerPila(Pila* ppila, int *elem);
int pilaVacia(Pila pila);
void borrarPila(Pila *ppila); //eliminar todos los elementos
							 //y dejar la pila vacia

#endif /* PILA_H_ */
