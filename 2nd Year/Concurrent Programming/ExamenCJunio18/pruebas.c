/*
 * pruebas.c
 *
 *  Created on: 20 abr. 2019
 *      Author: jj
 */
#include <stdio.h>
#include <stdlib.h>
#include "Cifrado.h"
void mostrarCifrado(TCifrado cf){
	if(cf==NULL){
			printf("Esta vacio");
		}
	while(cf!=NULL){
		printf("Box: %d, %d, %d \n",cf->esSBox,cf->bitACambiar,cf->valorASumar);
		cf=cf->sig;
	}

	printf("\n");
}
int main(){
	TCifrado cp;
	//TCifrado b1 = malloc(sizeof(struct TBox));
	struct TBox b1= (struct TBox) {1,CAMBIA_BIT_POS_0,0x8F,NULL};
	struct TBox b2= (struct TBox) {1,CAMBIA_BIT_POS_0,0x8F,NULL};
	struct TBox b3= (struct TBox) {1,CAMBIA_BIT_POS_0,0x8F,NULL};
	unsigned char ok;
	ok=0;
	crearEsquemaDeCifrado(&cp);
	printf("%d\n",ok);
	insertarBox(&cp,b1,&ok);
	printf("%d\n",ok);
	mostrarCifrado(cp);
	ok=0;
	insertarBox(&cp,b2,&ok);
	printf("%d\n",ok);
	mostrarCifrado(cp);

	return EXIT_SUCCESS;
}
