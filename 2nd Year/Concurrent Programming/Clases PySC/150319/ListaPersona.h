/*
 * ListaPersona.h
 *
 *  Created on: 14 mar. 2019
 *      Author: mmar
 */

#ifndef LISTAPERSONAS_H_
#define LISTAPERSONAS_H_


typedef struct NodoPersona * ListaPersona;
struct Persona{
	char nombre[10];
	char apellido[10];
	int edad;
};
struct NodoPersona{
	struct Persona persona;
	ListaPersona sig;
};

int crear(ListaPersona *l);
int insertarPrimero(ListaPersona *l,struct Persona pers);
int insertarFinal(ListaPersona *l,struct Persona pers);
int insertarOrdenado(ListaPersona *l, struct Persona pers);
int crearDeFichero(ListaPersona *l, const char * nombreFichero);
int crearDeFicheroGenerico(ListaPersona *l, const char * nombreFichero, int (*insertar)(ListaPersona*, struct Persona));
void imprimir(ListaPersona l);
void imprimirFicheroBinario(ListaPersona l,const char *nombreFichero);
void eliminar(ListaPersona *l);

#endif /* LISTAPERSONAS_H_ */
