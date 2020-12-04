#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "../Practica2/arbolbb.h"

const int TAM=10;

int main02(){

/* Parte 0
 * char nombreFichero[150];
 * sprintf(nombreFichero,"//home//jj//Escritorio//Universidad//2ºCarrera//2ºCuatrimestre//Programación y Sistemas de Concurrencia//Practica 2//practica%d.bin",(int)time(NULL));
*/
	//1º parte
	srand(time(NULL));
	FILE *pin;
	//pin = fopen(nombreFichero,"wb");
	pin = fopen("//home//jj//Escritorio//Universidad//2ºCarrera//2ºCuatrimestre//Programación y Sistemas de Concurrencia//Practica 2//p2.bin","wb");
	for(int i=0;i<TAM;i++){
		int num = rand() % TAM;
		printf("%d ", num);
		fwrite(&num,1,sizeof(num),pin);
	}
	printf("\n");
	fclose(pin);
	//2º parte
	FILE *pout;
	//pout = fopen(nombreFichero,"rb");
	pout = fopen("//home//jj//Escritorio//Universidad//2ºCarrera//2ºCuatrimestre//Programación y Sistemas de Concurrencia//Practica 2//p2.bin","rb");
	for(int i=0;i<TAM;i++){
		int num;
		fread(&num,1,sizeof(num),pout);
		printf("%d ",num);
	}
	fclose(pout);
	printf("\n ");


	//3º parte
	T_Arbol arbol;
	Crear(&arbol);
	FILE *pfile;
		//pout = fopen(nombreFichero,"rb");
		pfile = fopen("//home//jj//Escritorio//Universidad//2ºCarrera//2ºCuatrimestre//Programación y Sistemas de Concurrencia//Practica 2//p2.bin","rb");
		for(int i=0;i<TAM;i++){
			int num2;
			fread(&num2,1,sizeof(num2),pfile);
			Insertar(&arbol,num2);
		}
		fclose(pfile);
		Mostrar(arbol);
		printf("\n");

	//4º Parte

		FILE *salida;
		salida = fopen("//home//jj//Escritorio//Universidad//2ºCarrera//2ºCuatrimestre//Programación y Sistemas de Concurrencia//Practica 2//p2_ord.bin","wb");
		Salvar(arbol,salida);
		fclose(salida);

	//5º Parte
		Destruir(&arbol);
	return EXIT_SUCCESS;
}
