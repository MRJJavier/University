#include "ListaPersona.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int funcion1(){
	FILE *pf;
	pf = fopen("texto.txt","w");//abierto para escritura. Si no existe se crea. Si existe, se vacía.
			// nombre/dir fichero, w: escribe sobrescribiendo
			//Si el puntero es NULL entonces no se ha ejecutado correctamente la operación
	if (pf==NULL){
		perror("error en la apertura del fichero");

	} else{
		fprintf(pf,"Treinta 30 bytes enviados.....");//se escriben caracteres
		fclose(pf);
	}
	return 0;
}
int funcion2(){
	FILE *pf;
	char cadena[50];
	pf = fopen("texto.txt","r");//abierto para lectura
	if(pf!=NULL){
		fscanf(pf,"%s",cadena);
		printf("%s",cadena);
		fclose(pf);
	}else{
		perror("Error en la apertura del fichero");
	}
	return 0;
}

int funcion3(){
	/* Ficheros de texto / binario
	 * 		fprintf		/ fread
	 * 		fscanf		/ fwrite
	 */
	FILE *pf;
	char cadena[50];
	pf = fopen("texto.txt","r");
	if(pf!=NULL){
		//fread(direccion{cadena},tamaño{1},nº de bloques{7},source{pf});
		fread(cadena,1,7,pf);
		cadena[8]=0;
		printf("%s\n",cadena);
		fclose(pf);
	}else{
		perror("error en la apertura del fichero");
	}
	return 0;
}


int funcion4(){
	FILE *pf;
	char cadena[50];
	int numero;
	pf = fopen("texto.txt","r");
	if (pf!=NULL){
		fscanf(pf,"%s",cadena); // los primeros bytes se interpretan como caracteres
		fscanf(pf,"%d",&numero); // los siguientes se interpretan como numero
		printf("%s---%d\n",cadena,numero);
		fclose(pf);
	} else
		perror("error en la apertura del fichero");
	return 0;
}

int funcion5(){
	FILE *pf;
	char texto[50]="Esto es un ejemplo más largo";
	pf = fopen("texto2.txt","w");
	if (pf!=NULL){
		fwrite(texto,1,strlen(texto),pf);
		fclose(pf);
	} else
		perror("error en la apertura del fichero");
	return 0;
}


int funcion6(){ //el final del fichero se puede controlar con el valor devuelto por fread
	int nbytes;
	char texto[50];
	FILE *pf;
	pf = fopen("texto.txt","r");
	if (pf != NULL){
		nbytes = fread(texto,1,50,pf);
		printf("%d",nbytes);
		fclose(pf);
	}else
		perror("error en la apertura del fichero");
	return 0;
}

int funcion7(){
	ListaPersona l;
	//crearDeFichero(&l,"ListaPersonas.txt");
	crearDeFicheroGenerico(&l,"ListaPersonas.txt",insertarFinal);
	imprimir(l);
	imprimirFicheroBinario(l,"ListaPersonas.bin");
	return 0;
}

void leerFicheroBinario(const char * nombre){
	FILE *pf = fopen(nombre,"rb");
	struct Persona pers;
	if (pf==NULL) perror("no se puede abrir el fichero");
	else {
		while (fread(&pers,sizeof(struct Persona),1,pf)==1){
			printf("%s %s %u\n",pers.nombre,pers.apellido,pers.edad);
		}
		fclose(pf);
	}
}

int main(){
	//funcion1();
	//funcion2();
	//funcion3();
	//funcion4();
	//funcion5();
	return 0;
}
