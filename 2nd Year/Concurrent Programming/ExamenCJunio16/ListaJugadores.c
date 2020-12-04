/*
 * ListaJugadores.c
 *
 *  Created on: 24 abr. 2019
 *      Author: jj
 */
#include <stdio.h>
#include <stdlib.h>
#include "ListaJugadores.h"

void crear(TListaJugadores *lj){
	*lj=NULL;
}
void insertar(TListaJugadores *lj,unsigned int id){
	TListaJugadores ant=NULL, act=*lj;
	while(act!=NULL && act->numjug <= id){
		ant=act;
		act=act->sig;
	}

	if(act==NULL){
		TListaJugadores aux =malloc(sizeof(struct Nodo));
		aux->numjug=id;
		aux->numgol=1;
		aux->sig=NULL;
		if(ant==NULL){
			*lj=aux;
		}else{
			ant->sig=aux;
		}
	}else{
			if(act->numjug == id){
				act->numgol++;
			}else{
				TListaJugadores aux =malloc(sizeof(struct Nodo));
				aux->numjug=id;
				aux->numgol=1;
				aux->sig=act;
				if(ant==NULL){
					*lj=aux;
				}else{
					ant->sig=aux;
				}
			}

	}
}
void recorrer(TListaJugadores lj){

}
int longitud(TListaJugadores lj){

}
void eliminar(TListaJugadores *lj,unsigned int n){

}
unsigned int maximo(TListaJugadores *lj){

}
void destruir(TListaJugadores *lj){

}

