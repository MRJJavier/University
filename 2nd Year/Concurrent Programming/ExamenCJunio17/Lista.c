/*
 * Lista.c
 *
 *  Created on: 21 abr. 2019
 *      Author: jj
 */
#include <stdio.h>
#include <stdlib.h>
#include "Lista.h"

void crearLista(TLista *lista){
 *lista=NULL;
}
void insertarPunto(TLista *lista, struct Punto punto, int *ok){
	TLista ant,act;
	TLista aux= malloc(sizeof(struct Nodo));
	ant=NULL;
	act=*lista;

	while(act!=NULL && punto.x < (act->p)->x){
		ant = act;
		act=act->sig;
	}

	if(ant==NULL && act==NULL){
		*(aux->p)=punto;
		aux->sig=NULL;
		*lista=aux;
		*ok=1;
	}else if(act!=NULL && punto.x != (act->p)->x){
		*(aux->p)=punto;
		aux->sig=act;
		if(ant==NULL){
			*lista=aux;
		}else{
			ant->sig=aux;
		}
		*ok=1;
	}else if(ant!=NULL && act==NULL){
		*(aux->p)=punto;
		aux->sig=NULL;
		ant->sig=aux;
	}else{
		*ok=0;
	}
}
void eliminarPunto(TLista *lista, float x, int *ok){
	TLista ant,act;
	ant=NULL;
	act=*lista;
	while(act!=NULL && (act->p)->x != x){
		ant=act;
		act=act->sig;
	}

	if(act==NULL){
		*ok=0;
	}else if(ant==NULL && act!=NULL){
		*lista=act->sig;
		free(act);
		*ok=1;
	}else{
		ant->sig=act->sig;
		free(act);
		*ok=1;
	}
}
void mostrar_lista(TLista lista){
	if(lista==NULL){
		printf("Lista vacia");
	}
	while(lista!=NULL){
		printf("Punto. x:%f, y:%f \n",(lista->p)->x,(lista->p)->x);
		lista=lista->sig;
	}
}
void destruir(TLista *lista){
	TLista aux;
	while(*lista!=NULL){
		aux=*lista;
		*lista=aux->sig;
		free(aux->p);
		free(aux);
	}

}
void leePuntos(TLista *lista,char * nFichero){
	FILE *fin;
	struct Punto p;
	int ok;
	if((fin=fopen(nFichero,"rb"))==NULL){
		perror("Error al abrir el fichero");
		fflush(stdout);
		exit(-1);
	}
	while(fread(&p,sizeof(struct Punto),1,fin)){
		insertarPunto(lista,p,&ok);
	}
	fclose(fin);
}

int main(){
	return EXIT_SUCCESS;
}
