#include <stdio.h>
#include <stdlib.h>
#include "Cola.h"

int main03(){
	Cola cola;
	int v[4]={5,2,4,6};
	int j;
	printf("Creo cola y la recorro\n");
	crear(&cola);
	recorrer(cola);
	printf("¿Esta la cola vacia? (1 -> Si, 0 -> No): %d \n\n",colaVacia(cola));
	printf("Inserto un elementos y recorro la cola\n");
	for(int i=0;i<4;i++){
		insertar(&cola,&(v[i]));
		recorrer(cola);
	}
	printf("¿Esta la cola vacia? (1 -> Si, 0 -> No): %d \n\n",colaVacia(cola));
	printf("Extraigo elementos, los muestro y recorro la cola\n");
	for(int i=0;i<4;i++){
		extraer(&cola,&j);
		recorrer(cola);
	}
	printf("¿Esta la cola vacia? (1 -> Si, 0 -> No): %d \n\n",colaVacia(cola));
	printf("Vuelvo a insertar los mismos elementos\n");
	for(int i=0;i<4;i++){
		insertar(&cola,&(v[i]));
		recorrer(cola);
	}
	printf("¿Esta la cola vacia? (1 -> Si, 0 -> No): %d \n\n",colaVacia(cola));
	printf("Destruyo la cola y la recorro\n");
	destruir(&cola);
	recorrer(cola);
	printf("¿Esta la cola vacia? (1 -> Si, 0 -> No): %d \n\n",colaVacia(cola));

	return EXIT_SUCCESS;
}
