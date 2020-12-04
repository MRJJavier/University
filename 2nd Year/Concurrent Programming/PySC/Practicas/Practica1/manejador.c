#include "gestion_memoria.h"
#include <stdlib.h>
#include <stdio.h>

/* Crea la estructura utilizada para gestionar la memoria disponible. Inicialmente, sólo un nodo desde 0 a MAX */
void crear(T_Manejador* pman){
	T_Manejador aux = (T_Manejador)malloc(sizeof(struct T_Nodo));
	aux->inicio=0;
	aux->fin=999;
	aux->sig=NULL;
	*pman=aux;
}
/* Destruye la estructura utilizada (libera todos los nodos de la lista. El parámetro manejador debe terminar apuntando a NULL */
void destruir(T_Manejador* pman){
	T_Manejador aux=(T_Manejador)malloc(sizeof(struct T_Nodo));
	while(*pman!=NULL){
		aux=*pman;
		*pman=(*pman)->sig;
		free(aux);
	}
}
/* Devuelve en dir la dirección de memoria simulada (unsigned) donde comienza el trozo de memoria continua de tamaño tam solicitada.
Si la operación se pudo llevar a cabo, es decir, existe un trozo con capacidad suficiente, devolvera TRUE (1) en ok; FALSE (0) en otro caso.
 */
void obtener(T_Manejador *pman, unsigned tam, unsigned* dir, unsigned* ok){
	T_Manejador ant,act;
	ant=NULL;
	act=*pman;
	while(act!=NULL && (((act)->fin)-((act)->inicio))+1<tam){
		ant=act;
		act=act->sig;
	}
	if(act==NULL){
		*ok=0;
	}else{
		*ok=1;
		*dir=act->inicio;
		act->inicio=act->inicio+tam;
		if(act->inicio > act->fin){
			if(ant==NULL){
				*pman=act->sig;
			}else{
			ant->sig=act->sig;
			}
			free(act);
		}
	}
}

// obtiene, si es posible, la memoria que se pide (tam),
//pero se extrae del nodo de la lista que tenga la cantidad de memoria más cercana a tam.
void obtenerOptimizado(T_Manejador *pman, unsigned tam, unsigned* dir, unsigned* ok){
	T_Manejador ant,act;
	unsigned opt1,opt2;
	opt1=0;
	opt2=0;
	ant=NULL;
	act=*pman;
	while(act!=NULL){
		if(act->fin - act->inicio +1 >= tam){
			opt2=opt1;
			opt1=act->fin - act->inicio +1 ;
			if(opt2!=0 && opt1 > opt2){
				opt1 = opt2;
			}
		}
		ant=act;
		act=act->sig;
	}
	ant=NULL;
	act=*pman;
	while(opt1 != 0 && act!=NULL && (((act)->fin)-((act)->inicio))+1 != opt1){
		ant=act;
		act=act->sig;
	}
	if(act==NULL || opt1==0){
		*ok=0;
	}else{
		*ok=1;
		*dir=act->inicio;
		act->inicio=act->inicio+tam;
		if(act->inicio > act->fin){
			if(ant==NULL){
				*pman=act->sig;
			}else{
				ant->sig=act->sig;
			}
				free(act);
		}
	}
}
/* Muestra el estado actual de la memoria, bloques de memoria libre */
void mostrar (T_Manejador man){
	printf("Memoria disponible: [");
	while(man!=NULL){
		printf("[%u %u]",man->inicio,man->fin);
		man=man->sig;
	}
	printf("]\n*****\n");
}
/* Devuelve el trozo de memoria continua de tamaño tam y que
 * comienza en dir.
 * Se puede suponer que se trata de un trozo obtenido previamente.
 */
void devolver(T_Manejador *pman,unsigned tam,unsigned dir){
	T_Manejador act=*pman,ant=NULL;
	T_Manejador aux;
	while(act!=NULL && act->inicio<dir){
		ant=act;
		act=act->sig;
	}
	/*Si anterior es nulo entonces puede ser que:
	 * El manejador este vacio
	 * Hay que introducirlo en la 1º posicion pero no juntar nodos
	 * Modifico el nodo actual
	 */
	if(ant==NULL){
		if(act == NULL || act ->inicio>dir+tam){
			aux=(T_Manejador)malloc(sizeof(struct T_Nodo));
			aux->inicio=dir;
			aux->fin=dir+tam-1;
			aux->sig=act;
			*pman=aux;
		}
		if(act -> inicio == dir + tam){
			act->inicio=dir;
		}
	}
	/*Si actual es nulo y anterior no lo es entonces puede pasar:
	 * Modificar nodo anterior
	 * Insertar el nodo en la ultima posicion
	 */
	if(ant != NULL && act==NULL){
		if(ant->fin == dir-1){
			ant->fin=dir+tam-1;
		}else{
			aux=(T_Manejador)malloc(sizeof(struct T_Nodo));
			aux->inicio=dir;
			aux->fin=dir+tam-1;
			aux->sig=NULL;
			ant->sig=aux;
		}
	}
	/*Si anterior y actual no son nulos puede pasar:
	 * Insertar Nodo entre ambos
	 * Modificar con anterior
	 * Juntar con actual e insertar
	 * Modificar anterior y actual y liberar actual
	 */
	if(ant!=NULL && act!=NULL){
		if(ant->fin != dir-1 && act->inicio>dir+tam){
			T_Manejador aux= (T_Manejador)malloc(sizeof(struct T_Nodo));
			aux->inicio=dir;
			aux->fin=dir+tam-1;
			aux->sig=act;
			ant->sig=aux;
		}
		if(ant->fin == dir-1 && act->inicio>dir+tam){
			ant->fin=dir+tam-1;
		}
		if(ant->fin != dir-1 && act->inicio == dir+tam){
			act->inicio=dir;
		}
		if(ant->fin == dir-1 && act->inicio == dir+tam){
			ant->fin=act->fin;
			ant->sig=act->sig;
			free(act);
		}
	}
}
