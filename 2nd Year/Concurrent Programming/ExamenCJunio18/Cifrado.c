/*
 * Cifrado.c
 *
 *  Created on: 20 abr. 2019
 *      Author: jj
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Cifrado.h"
void crearEsquemaDeCifrado (TCifrado *cf){
	*cf=NULL;
}

void insertarBox (TCifrado * cf, struct TBox box, unsigned char *ok){
	TCifrado ant=NULL;
	TCifrado act=*cf;
	while(act!=NULL){
		ant=act;
		act=act->sig;
	}
	if(ant==NULL){
		if(box.esSBox==1){
			TCifrado aux= malloc(sizeof(struct TBox));
			*aux=box;
			aux->sig=NULL;
			*cf=aux;
			*ok=1;
		}else{
			*ok=0;
		}
	}
	if(ant!=NULL){
		if((ant->esSBox==1 && box.esSBox==0) || (ant->esSBox==0 && box.esSBox==1)){
			TCifrado aux= malloc(sizeof(struct TBox));
			*aux=box;
			act=aux;
			act->sig=NULL;
			ant->sig=act;
			*ok=1;
		}else{
			*ok=0;
		}
	}
}

unsigned char aplicarBox (struct TBox box, unsigned char valor){
	if(box.esSBox==1){
		valor+=box.valorASumar;
	}else if(box.bitACambiar==CAMBIA_BIT_POS_0){
		valor= valor ^ 0b00000001;
	}else{
		valor= valor ^ 0b10000000;
	}

	return valor;
}

unsigned char aplicarEsquemaDeCifrado(TCifrado cf, unsigned char valor){
	while(cf!=NULL){
		aplicarBox(*cf,valor);
		cf=cf->sig;
	}
	return valor;
}

void escribirAFichero(char *nm, TCifrado cf){
	FILE *fout;
	if((fout=fopen(nm,"wb"))==NULL){
		printf("No se pudo abrir el fichero");
		fflush(stdout);
		exit(-1);
	}
	while(cf!=NULL){
		if(!fwrite(cf,sizeof(struct TBox),1,fout)){
			printf("No se puede escribir en el archivo");
		}
		cf=cf->sig;
	}

	fclose(fout);
}

void destruirEsquemaDeCifrado (TCifrado *cf){
	TCifrado aux;
	while(*cf!=NULL){
		aux=*cf;
		*cf=(*cf)->sig;
		free(aux);
	}
	*cf=NULL;

}


