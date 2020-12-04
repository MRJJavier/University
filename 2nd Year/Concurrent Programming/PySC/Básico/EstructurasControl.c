/*
 * EstructurasControl.c
 *
 *  Created on: 6 mar. 2019
 *      Author: José Javier Morente
 */


#include <stdio.h>

int esPrimo(int n){
	if(n<=0){
		perror("Parametro invalido");
		return -1;
	}
	if(n==1 || n==2){
		return 1;
	}
	int primo=1;
	int divisor=2;
	while(primo && divisor*divisor<=n){
		if(n%divisor==0){
			primo=0;
		}
		divisor++;
	}
	return primo;
}

int main3(){
	int nPrimo;
	printf("Cuantos primos quieres?");
	scanf("%d",&nPrimo);
	int pPrimo=1;
	while (0<nPrimo){
		if(esPrimo(pPrimo)){
			printf("%d es primo \n",pPrimo);
			nPrimo--;
		}
		pPrimo++;
	}
return 0;
}



