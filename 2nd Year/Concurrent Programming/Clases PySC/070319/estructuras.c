#include<stdio.h>
struct Persona{
	char nombre[25];
	char inicial;
	int edad;

};

void leerPersona(struct Persona * p){
	printf("Introduce un nombre y una edad: ");
	scanf("%s %d",&((*p).nombre), &(p -> edad));// (*p).campo == p->campo

}

void escribirPersona(struct Persona p){
	printf("Nombre: %s, Edad: %d\n",p.nombre,p.edad);
}

void leerListaPersona(struct Persona *lista, int l){
	int i;
	for(i=0;i<l;i++){
		leerPersona(lista+i);
		//leerPersona(&lista[i]);
	}
}

void escribirListaPersona(struct Persona *lista, int l){
	int i;
	for(i=0;i<l;i++){
		escribirPersona(*(lista+i));
		//escribirPersona(lista[i]);
	}
}
/* Struct Persona p
 * p.nombre[3] == *(p.nombre+3)
 * p.inicial
 * p.edad
 */
//fflush(stdout) <-- sirve para limpiar el buffer



int main1(){
	/*
	struct Persona p;
	leerPersona(&p);
	escribirPersona(p);
	*/
	struct Persona lista[3];
	leerListaPersona(lista,3);
	escribirListaPersona(lista,3);


	return 0;
}
