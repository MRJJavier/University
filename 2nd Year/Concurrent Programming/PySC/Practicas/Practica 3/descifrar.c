/*
 * descifrar.c
 *
 *  Created on: 28 mar. 2019
 *      Author: jj
 */
#include<stdio.h>
#include <stdlib.h>
#include<string.h>
//DESENCRIPTACION LITTLE-ENDIAN:
//little-endian-> 7BAC45 -> se traduce por -> 45AC78
void decrypt(unsigned int *v, unsigned int* k){//hacer una referencia a un arrray es menos caro que pasar una copia del array aunque no lo modifiquemos
	//pasamos el puntero que nos ocupa menos memoria y como sabemos que no vamos a modificarlo no hay problema.
	unsigned int v0 = v[0], v1 = v[1], sum= 0xC6EF3720;
	unsigned int delta = 0x9e3779b9;
	unsigned int k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];
	for(int i=0;i<32; i++){//desplazamientos >> y <<
		v1 -= ((v0 << 4) + k2 ^ v0 + sum ^ (v0 >>5) + k3);
		v0 -=((v1<<4) + k0  ^ v1 + sum ^ (v1>>5) + k1);
		sum -=delta;
	}
	v[0] = v0;
	v[1] = v1;
}
int main04(int argc, char argv[]){
	//le pedimos al usuario el nombre del fichero de entrada / salida
	FILE *fent, *fsal; //Punteros a ficheros.
	unsigned int lSize, lSize2;
	char  *buf, *buf2;
	unsigned int k[4], v[2];
	size_t leidos;
	int i, veces;
	char entrada[50];
	char salida [50];
	//Pedir por teclado al usuario el fichero de entrada y salida.
	fflush(stdout);
	printf("Introduce el nombre del fichero de ENTRADA: \n");
	fflush(stdout);
	scanf("%s ",entrada);
	fflush(stdin);

	printf("Introduce el nombre del fichero de SALIDA: \n");
	fflush(stdout);
	scanf("%s ", salida);
	fflush(stdin);

	if((fent = fopen(entrada, "rb"))==NULL){
		printf("Error leyendo el fichero \n");
		fflush(stdout);
		exit(-1);
	}
	//si hay algun problema el fopen me va a retornar NULL por eso hacemos las comparaciones al principio, antes de hacer nada mas
	if((fsal = fopen(salida, "wb"))==NULL){
		printf("Error creando el fichero.  \n");
		fflush(stdout);
		fclose(fent);//aqui tenemos que cerrar la apertura de fichero, en el if anterior no haria falta
		exit(-1);
	}
	//Si todo esto va bien, los punteros a ficheros creados al principio apuntan al fichero de entrada y de salida.

	k[0] = 128;
	k[1] = 129;
	k[2] = 130;
	k[3] = 131;
	/*Desde fent, con el tamaño especificado, numero de bloques (1) y lo almacenamos en (void Ž*) &lSize.*/
	fread((void *)  &lSize, sizeof(unsigned int), 1, fent);

	if(lSize % 8){//Si no es multiplo de 8, le sumamos tantos bytes que le hagan falta para ser modulo 8.
		lSize2 = lSize + (8 - (lSize % 8));
	}else{
		lSize2 = lSize;
	}
	printf("%d, %d ", lSize, lSize2);
	buf = (char *) malloc (sizeof(char) * (lSize2)); //preparamso el buffer para lo que vamos a ir leyendo
	if (buf == NULL){
		printf("Error memoria insuficiente. \n");
		fflush(stdout);
		fclose(fent);
		fclose(fsal);
		exit(-1);
	}
	/*Lectura en Memoria*/
	//leemos de fent, con bloques del tamaño sizeof, tantos bloques como haya en lSize2 y lo guardamos en el buffer
	leidos = fread((void *) buf, sizeof(char), lSize2, fent);
	if(leidos != lSize2){//esto puede ocurrir si leemos mas bloques de los especificados.
		printf("Error en lectura del fichero. \n");
		fflush(stdout);
		fclose(fent);
		fclose(fsal);
		exit(-1);
	}
	//IMPORTANTE acordarnos de cerrar los fopne al final de la ejecucion.

	fclose(fent);
//desencriptamos el archivo, troceando toda la informacion del buffer y desencriptandola.
	veces = lSize / 8; //veces = numero de iteraciones que hay que realizar para desencriptar en su totalidad
//usamos lSize en vez de lSize2 porque en lSize2 tenemos el relleno y en lSize solo el tamaño real y la practica nos dice
	//que no queremos desencriptar el  relleno.
	buf2 = buf; //salvamos la referencia del buffer 1 cuando vamos recorriendolo y estar tranquilos de no perderla
	for(int i=0; i<veces;i++){
		//el origen es el buf2 y el destino es v y copiamos bloques de tamaño 8
		memcpy((void*) v, (void *) buf2, 8);
		decrypt(v,k);//devolvemos en v lo que hemos desencriptado
		buf2 += 8;
		//escribimos en fsal, bloques de tam sizeof(char) tantos bloques como diga el num (8) y cogemos la informacion de v.
		fwrite((void *) v, sizeof(char), 8, fsal); //escribimos en el fichero de salida lo que queriamos escribir pero desencriptado.
	}
	if (lSize % 8){
		//para desencriptar el ultimo bloque y asegurarnos que no desencriptamos basura.
		memcpy((void*) v, (void *) buf2, 8);
		decrypt(v,k);
		fwrite((void *)v, sizeof(char), lSize % 8, fsal);
	}
	free((void *) buf); //IMPORTANTE: liberar el buffer
	fclose(fsal);

	return EXIT_SUCCESS;
}

