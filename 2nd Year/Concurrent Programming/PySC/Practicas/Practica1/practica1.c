/*
 ============================================================================
 Name        : Practica1.c
 Author      :
 Version     :
 Copyright   : Your copyright notice
 Description :
 ============================================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include "gestion_memoria.h"

int main01(void) {

	T_Manejador manej;
	unsigned ok;
	unsigned dir;

	crear(&manej);
	mostrar(manej);

	obtener(&manej,500,&dir,&ok); /* Se ha hecho una foto. Se necesita memoria */
	if (ok) {
		mostrar(manej);
		printf("la direccion de comienzo es: %d\n", dir);
	} else {
		printf("No es posible obtener esa memoria\n");
	}

	devolver(&manej, 200,0); /* Se ha enviado parte de la foto. Ya se puede borrar */
	mostrar(manej);


obtener(&manej,250,&dir,&ok); /* Se ha hecho otra foto */
if (ok) {
		mostrar(manej);
		printf("la direccion de comienzo es: %d\n", dir);
	} else {
		printf("No es posible obtener esa memoria\n");
	}

	devolver(&manej,100,500); /* Se ha enviado parte de la foto. Ya se puede borrar */
	mostrar(manej);

 	obtener(&manej,250,&dir,&ok); /* Se ha hecho otra foto */
	if (ok) {
		mostrar(manej);
		printf("la direccion de comienzo es: %d\n", dir);
	} else {
		printf("No es posible obtener esa memoria\n");
	}

	printf("--------- \n\nUso del método obtener \n");
		obtener(&manej,50,&dir,&ok); /* Se ha hecho otra foto */
			if (ok) {
				mostrar(manej);
				printf("la direccion de comienzo es: %d\n", dir);
			} else {
				printf("No es posible obtener esa memoria\n");
			}
			printf("Devuelvo lo obtenido en el método obtener\n");
			devolver(&manej,50,dir);
			mostrar(manej);


	printf("---------\n\nUso del método obtenerOptimizado \n");
	obtenerOptimizado(&manej,50,&dir,&ok); /* Se ha hecho otra foto */
		if (ok) {
			mostrar(manej);
			printf("la direccion de comienzo es: %d\n", dir);
		} else {
			printf("No es posible obtener esa memoria\n");
		}
		printf("Devuelvo lo obtenido en el método obtenerOptimizado\n");
		devolver(&manej,50,dir);
		mostrar(manej);
		printf("\n\n");

	destruir(&manej);
	mostrar (manej);

	printf("Fin Programa\n");

	return EXIT_SUCCESS;
}

