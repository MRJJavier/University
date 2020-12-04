#include <stdio.h>
#include <string.h>

int esVocal(char c){
	char vocales[10]={'a','e','i','o','u','A','E','I','O','U'};
	int es=0;
	for(int i=0;i<sizeof(vocales);i++){
		if(c==vocales[i]){
			es++;
		}
	}
	return 1<=es;
}
int nVocales(char * str){
	int nVoc = 0;
	char *ptr = str;
	while( *ptr != '\0'){
		if(esVocal(*ptr)){
			nVoc++;
		}
		ptr++; //ptr = ptr +1
	}
	return nVoc;
}


int main(){
	char str[15] = "Hola Mundo";
	printf("vocales de %s: %d",str,nVocales(str));
	return 0;
}
