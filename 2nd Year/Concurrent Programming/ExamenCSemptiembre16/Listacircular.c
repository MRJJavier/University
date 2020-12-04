/*
 * Listacircular.c
 *
 *  Created on: 24 abr. 2019
 *      Author: jj
 */
#include <stdio.h>
#include <stdlib.h>
#include "Listacircular.h"

void Crear (LProc *lista){
	*lista=NULL;
}

void AnadirProceso (LProc *lista, int idproc){
	LProc suc=(*lista)->sig;
	int cont=1;

	//Comprueba que el idproc no este en la lista
	while((*lista)->idproc != suc->idproc && suc->idproc != idproc){
		if((suc->sig)->idproc == idproc) cont=0;
		suc=suc->sig;
	}

	if(cont){
		LProc aux = malloc(sizeof(struct Nodo));
		aux->idproc=idproc;
		if(*lista==NULL){
			*lista=aux;
			aux->sig=*lista;
		}else{
			aux->sig=(*lista)->sig;
			(*lista)->sig=aux->sig;
			*lista=aux;
		}
	}
}

void EjecutarProcesos(LProc lista){
	LProc suc=lista->sig;
	int cont=0;
	while(lista->idproc != suc->idproc){
		cont++;
	}
	while(cont!=0){
		printf("idproc: %d\n",lista->idproc);
		cont--;
		lista=lista->sig;
	}

}
//Se da por hecho en el enunciado que el idproc se encuentra en la lista
void EliminarProceso(int idproc, LProc *lista){
	LProc ant=*lista, act=((*lista)->sig);
	while(act->idproc != idproc){
		ant=act;
		act=act->sig;
	}
	ant->sig=act->sig;
	if(*lista==act){
		free(act);
		*lista=ant;
	}
	if(act==ant){
		free(act);
		*lista=NULL;
	}

}
void EscribirFichero (char *nomf, LProc *lista){
	FILE *fout;
	LProc aux=*lista;
	int cont=0;
	if((fout=fopen(nomf,"wb"))==NULL){
		printf("No se pudo abrir el fichero");
		fflush(stdout);
		exit(-1);
	}
	while(aux!=NULL){
		EliminarProceso(aux->idproc,&aux);
		cont++;
	}

	fwrite(&cont,sizeof(int),1,fout);

	while(*lista!=NULL){
		fwrite(*lista,sizeof(LProc),1,fout);
		EliminarProceso((*lista)->idproc,lista);
	}

}

int main(){
	return EXIT_SUCCESS;
}

