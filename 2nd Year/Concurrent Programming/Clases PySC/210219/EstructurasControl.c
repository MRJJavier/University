
/*
	for(i=1; i<=20; i++){
		if(esPrimo(i)) printf("%d-",i);
	}
	*/
#include <stdio.h>

int esPrimo(int n){
	if(n<=0){
		perror("parámetro inválido");
		return -1;
	}
	if (n==1 || n==2) return 1;
	int d=2;
	int primo =1 ;
	while(primo && d*d<=n){
		if (n%d == 0) primo = 0;
		d++;
	}
	return primo;
}

int main3(){
	int num;
	printf("Cuantos primos quieres?");
	scanf("%d",&num);
	int i;
	int j;
	while (j<num){
		if(esPrimo(i)){
			printf("%d",i);
			j++;
		}
		i++;
	}
return 0;
}

