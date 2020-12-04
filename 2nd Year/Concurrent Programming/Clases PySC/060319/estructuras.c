#include <stdio.h>
struct Persona{
	char nombre[25];
	char inicial;
	int edad;

};

void leerPersona(struct Persona * p){
	printf("Introduce un nombre y una edad: ");fflush(stdout);
	scanf("%s %d",&((*p).nombre), &(p -> edad));// (*p).campo == p->campo

}

void escribirPersona(struct Persona p){
	printf("nombre: %s, edad: %d\n",p.nombre,p.edad);
}

void escribirLista(struct Persona *lista, int l){
	//leerLista();
}
/* Struct Persona p
 * p.nombre[3] == *(p.nombre+3)
 * p.inicial
 * p.edad
 */
//fflush(stdout) <-- sirve para limpiar el buffer
