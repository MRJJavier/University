#include "ListaPersona.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int crear(ListaPersona *l){
	*l=NULL;
	return 0;
}
int insertarPrimero(ListaPersona *l,struct Persona pers){
	ListaPersona aux = (ListaPersona)malloc(sizeof(struct NodoPersona));
	aux->persona=pers;
	aux->sig=*l;
	*l=aux;
	return 0;
}
int insertarFinal(ListaPersona *l,struct Persona pers){
	ListaPersona ant,act;
	ant=NULL;
	act=*l;
	ListaPersona aux = (ListaPersona)malloc(sizeof(struct NodoPersona));
	aux->persona=pers;
	aux->sig=NULL;
	while(act!=NULL){
		ant=act;
		act=act->sig;
	}
	if(ant==NULL){
		*l=aux;
	}else{
		ant->sig=aux;
	}
	return 0;
}
int insertarOrdenado(ListaPersona *l, struct Persona pers){
	ListaPersona act = *l, ant=NULL;
	ListaPersona aux = (ListaPersona)malloc(sizeof(struct NodoPersona));
	aux->persona = pers;
	aux->sig=*l;
	while(act!=NULL && strcmp(act->persona.apellido,pers.apellido)<0){
		ant = act;
		act = act->sig;
	}
	if(ant==NULL){
		aux->sig=*l;
		*l=aux;
	}else{{
		aux->sig=act;
		ant->sig=aux;
	}
	return 0;
}
int crearDeFichero(ListaPersona *l, const char * nombreFichero){
	FILE *pf =fopen(nombreFichero,"r");
	struct Persona pers;
	if(pf==NULL) perror("error al abrir el fichero");
	else{
		crear(l);
		while(fscanf(pf,"%s %s %d",pers.nombre,pers.apellido,&pers.edad)==3){
			insertarOrdenado(l,pers);
		}
		fclose(pf);
	}
	return 0;
}
int crearDeFicheroGenerico(ListaPersona *l, const char * nombreFichero, int (*insertar)(ListaPersona*, struct Persona)){
	return 0;

}
void imprimir(ListaPersona l){
	printf("Lista Personas:\n");
	while(l!=NULL){
		printf("%s %s %u \n",l->persona.nombre,l->persona.apellido,l->persona.edad);
		l=l->sig;
	}
}

}
void imprimirFicheroBinario(ListaPersona l,const char *nombreFichero){
	FILE *pf = fopen(nombreFichero,"w");
	if (pf==NULL) perror("No existe el fichero");
	else{
		while(l!=NULL){
			fwrite(l->persona.nombre,1,10,pf);
			fwrite(l->persona.apellido,1,10,pf);
			fwrite(l->persona.edad,1,sizeof(int),pf);
			l=l->sig;
		}
	}
	fclose(pf);

}
void eliminar(ListaPersona *l){

}
