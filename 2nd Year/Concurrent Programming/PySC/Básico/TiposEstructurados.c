/*
 * TiposEstructurados6.c
 *
 *  Created on: 20 feb. 2019
 *      Author: mmar
 */

#include <stdio.h>
#include <string.h>
int main8(int argc, char ** args){
	int a[2]; //2 componentes, cada uno de 4 bytes (32*2 bits) 8 bytes total
	double d[4]; //4 componentes, cada uno de 8 bytes (64*4 bits) 32 bytes total
	char c[5]; //5 componentes, cada uno de 1 byte (8*5 bits) 5 bytes total
	float f[3];//3 componentes, cada uno de 4 bytes (32*3 bits) 12 bytes total

	/* 			 Ejemplo
	 * ----------------------------
	 *  Nombre   Dirección   Valor
	 * ----------------------------
	 * a//a[0]   1000-1003
	 *    a[1]   1004-1007
	 * d//d[0]   1008-1015
	 *    d[1]	 1016-1023
	 *    d[2]	 1024-1031
	 *    d[3]   1032-1039
	 * c//c[0]	 1040
	 * 	  c[1]	 1041
	 * 	  c[2]	 1042
	 * 	  c[3]	 1043
	 * 	  c[4]	 1044
	 * f//f[0]   1045-1047
	 * 	  f[1]	 1048-1050
	 * 	  f[2]	 1051-1053
	 */
	a[0] = 5;
	f[1] = 4.0;
	d[2] = 14.7;
	c[4] = 'a';

	printf("nombre: %c, \t direccion:%d\n",'a',a);
	printf("nombre: %c, \t direccion:%d\n",'b',f);
	printf("nombre: %c, \t direccion:%d\n",'c',c);
	printf("nombre: %c, \t direccion:%d\n",'d',d);
	// no se comprueban las cotas de los arrays, por lo que pueden sobrepasarse
	printf("nombre: %s \t direccion:%d, valor:%d\n","a[0]",&a[0],a[0]);
	//f[3] = 8.0;
	printf("nombre: %s \t direccion:%d, valor:%d\n","a[0]",&a[0],a[0]);
	//si nos salimos de la memoria tenemos un error en ejecución "segmentation fault"
	//f[33333]=0;
	//printf("%lf",f[33333]);
	return 0;
}

int main9(int argc,char ** args){
	//int a[2][3]; // 2 filas, 3 columnas, 6 componentes de 4 bytes (6*32 bits) 24 bytes en total
	char str[8];
	str[0] = 'H';
	str[1] = 'o';
	str[2] = 'l';
	str[3] = 'a';
	str[4] = '\0';//carácter 0 terminador de la cadena
	//str[4] = 0; //sirve igual
	//str[4] = (char) NULL; //sirve igual
	str[5] = 'M';
	//printf("String str: %s",str);
	//Este no lo muestra por pantalla
	//printf("%s\n",str[0]);
	//Hay que cambiar %s por %c
	//printf("%c\n",str[0]);

	int i;
	float f;
	char s[6];
	printf("Escribe un entero: ");
	scanf("%d",&i);
	printf("Ha escrito el entero: %d\n",i);
	printf("Escribe un float: ");
	scanf("%f",&f);
	printf("Ha escrito el float: %f\n",f);
	printf("Escribe una cadena: ");
	scanf("%s",s);
	printf("Ha escrito la cadena: %s\n",s);
	return 0;
}

int main10(int argc, char ** args){
/*funciones de librería para los string
 * strlen(x) <- devuelve la longitud de la cadena
 * strcmp(x,y) <- si son iguales devuelve 0
 * strcpy(x,y) <- copia la cadena y en x
 * strcat(x,y) <- concatena ambas cadenas
 */
	char c[15] = "Hola Mundo";
	printf("longitud de la cadena '%s': %d\n",c,strlen(c));
	char d[17] = "Adiós Mundo";
	printf("¿Son '%s' y '%s' iguales?:%d\n",c,d,strcmp(c,d));
	strcpy(c,d);
	printf("Copiado:%s\n",c);
	char e[50];
	strcpy(e,c);
	strcat(e,d);
	printf("Concatenado:%s\n",e);
	return 0;
}

int main11(int args, char **argc){
		char pBuscada[20];
		char palabra[20];
		printf("Busco la palabra: ");
		scanf("%s",pBuscada);
		while (1){
			printf("Introduce una cadena: (0 para terminar) ");
			scanf("%s",palabra);
			if (strcmp(palabra,"0")==0)
				break;
			if (strlen(palabra)<strlen(pBuscada))
				printf("%s es demasiado corta",palabra);
			else if (strcmp(palabra,pBuscada)==0){
				printf("Encontrada!!");
				break;
			}
			else if (strncmp(palabra,pBuscada,3)==0) //busca que coincidan los 3 primeros caracteres
				printf("Empiezan igual....");
			else
				printf("No es la palabra que estamos buscando");
		}
		return 0;
	}

