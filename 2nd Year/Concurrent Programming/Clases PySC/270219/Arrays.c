#include <stdio.h>
#include <string.h>


void elimina(char c,char cadena[]){

	int i,j;
	i = j = 0;
	while (cadena[i]!='\0'){
		if (cadena[i]!=c){
			cadena[j] = cadena[i];
			j++;
		}
		i++;
	}
	cadena[j]='\0';
}
int main12(int argc, char ** args){
	char cadena[20];
	char fin = 0;
	while (!fin){
		printf("Introduce una cadena (0 para terminar)");
		scanf("%s",cadena);
		if (strcmp(cadena,"0")==0) fin = 1;
		else {
			elimina('a',cadena);
			printf("cadena con la letra %c eliminada; %s \n",'a',cadena);
		}
	}
	return 0;
}

int main13(int argc, char ** args){
	for (int i = 0; i<argc; i++){
		printf("%s \n",args[i]);
	}
	return 0;
}
