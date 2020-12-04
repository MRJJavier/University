/*
 * Listacircular.h
 *
 *  Created on: 24 abr. 2019
 *      Author: jj
 */

#ifndef LISTACIRCULAR_H_
#define LISTACIRCULAR_H_

typedef struct Nodo *LProc;
struct Nodo{
	int idproc;
	struct Nodo *sig;
};

void Crear (LProc *lista);
void AnadirProceso (LProc *lista, int idproc);
void EjecutarProcesos(LProc lista);
void EliminarProceso(int idproc, LProc *lista);
void EscribirFichero ( char *nomf, LProc *lista);


#endif /* LISTACIRCULAR_H_ */
