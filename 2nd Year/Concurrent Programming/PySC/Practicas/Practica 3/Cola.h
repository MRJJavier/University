#ifndef COLA_H_

#define COLA_H_


typedef struct Nodo * Puntero;

struct Nodo{

unsigned v[2];

Puntero sig;

};


struct NodoCola{

Puntero primero;

Puntero ultimo;

};


typedef struct NodoCola Cola;


void crear(Cola *cola);

void insertar(Cola *cola,unsigned *v);

int extraer(Cola *cola, unsigned *v);

int colaVacia(Cola cola);

void recorrer(Cola cola);

void destruir(Cola *cola);


#endif /* COLA_H_ */
