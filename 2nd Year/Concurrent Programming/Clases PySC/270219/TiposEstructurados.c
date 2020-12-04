#include <stdio.h>
#include <string.h>

int main8(int arg, char ** args){
	int a[2]; // 8 bytes
	double c[4]; // 32 bytes
	char d[5]; // 5 bytes
	float f[3]; // 12 bytes

/*  Nombre   Dirección   Valor
 * a//a[0]   1000-1003
 *    a[1]   1004-1007
 * d//d[0]   1008-1015
 *    d[1]	 1016-1023
 *    d[2]	 1024-1031
 *    d[3]   1032-1038
 * c//c[0]	 1039
 * 	  c[1]	 1040
 * 	  c[2]	 1041
 * 	  c[3]	 1042
 * 	  c[4]	 1043
 */

	a[0]=5;
	f[1]=4.0;
	c[2]=14.7;
	d[4]='a';

	printf("nombre: %c,\t direccion:%d\n",'a',a);
	printf("nombre: %c,\t direccion:%d\n",'c',c);
	printf("nombre: %c,\t direccion:%d\n",'d',d);
	printf("nombre: %c,\t direccion:%d\n",'f',f);
	// no se comprueban las cotasd de los array, por lo que pueden sobrepasar
	printf("nombre: %s,\t direccion:%d,  valor:%d\n ","a[0]",&a[0],a[0]);
	f[3] = 8.0;
		printf("nombre: %s \t direccion:%d, valor:%d\n","a[0]",&a[0],a[0]);
		//si nos salimos de la memoria tenemos un error en ejecución "segmentation fault"
		//f[33333]=0;
		//printf("%lf",f[33333]);
		return 0;
	}

	int main9(int argc,char ** args){
		//int a[2][3]; // 2 filas, 3 columnas, 6 componentes de 4 bytes (6*32 bits)
		char str[8];
		str[0] = 'H';
		str[1] = 'o';
		str[2] = 'l';
		str[3] = 'a';
		str[4] = '\0';//carácter 0 terminador de la cadena
		//str[4] = 0;
		//str[4] = (char) NULL;
		str[5] = 'M';
		printf("%s\n",str);

		//printf("%s\n",str[0]);

		int x;
		float f;
		char s[6];
		scanf("%d",&x);
		printf("%d\n",x);
		scanf("%f",&f);
		printf("%f\n",f);

		scanf("%s",s);
		printf("%s\n",s);
		return 0;
	}

	int main10(int argc, char ** args){
	//funciones de librería para los string
		char c[15] = "Hola Mundo";
		printf("%s longitud:%ld\n",c,strlen(c));
		char d[17] = "Adiós Mundo";
		printf("%s iguales?:%d\n",c,strcmp(c,d));
		strcpy(c,d); // No se puede hacer str1 = str2, son punteros constantes, no strings.
		printf("copiado:%s\n",c);
		char e[50];
		strcpy(e,c);
		strcat(e,d);
		printf("concatenado:%s\n",e);
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

