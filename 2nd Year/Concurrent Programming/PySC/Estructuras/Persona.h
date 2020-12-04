/*
 * Persona.h
 *
 *  Created on: 13 mar. 2019
 *      Author: José Javier Morente
 */

#ifndef PERSONA_H_
#define PERSONA_H_

struct Persona{
	char nombre[50];
	int edad;
};

void leerPersona(struct Persona * p);
void escribirPersona(struct Persona p);
void leerListaPersona(struct Persona * lista, int l);
void escribirListaPersona(struct Persona * lista, int l);

#endif /* PERSONA_H_ */
