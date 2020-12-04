/*
 * Suma.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */

#include <stdio.h>
#include <string.h>

int suma(int *vector, int l){
	int sum=0;
	int *ptr=vector;
	for(int i=0;i<l;i++){
		sum=sum+ *ptr;
		ptr++;
	}
	return sum;
}

int main16(){
	int n,l;
		printf("De cuantos números quiere el vector?: ");
		scanf("%d",&n);
		int vector[n];
		printf("Introduzca los números en el vector: ");
		for(int i=0;i<n;i++){
			scanf("%d",vector+i);
		}
		printf("Cuantos números quiere sumar?:");
		scanf("%d",&l);
		printf("La suma de las primeras %d componentes del vector es: %d",l,suma(vector,l));
		return 0;
}
