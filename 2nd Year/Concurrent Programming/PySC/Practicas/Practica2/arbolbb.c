#include "../Practica2/arbolbb.h"

#include <stdio.h>
#include <stdlib.h>



// Crea la estructura utilizada para gestionar el árbol.
void Crear(T_Arbol* arbol){
	*arbol=NULL;
}
// Destruye la estructura utilizada y libera la memoria.
void Destruir(T_Arbol* arbol){
	if(*arbol!=NULL){
		Destruir(&(*arbol)->izq);
		Destruir(&(*arbol)->der);
		free(*arbol);
		*arbol=NULL;
	}

}
// Inserta num en el árbol. Si ya está insertado, no hace nada
void Insertar(T_Arbol* arbol,unsigned num){

	if(*arbol==NULL){
		*arbol= malloc(sizeof(struct T_Nodo));
		(*arbol)->dato=num;
		(*arbol)->der=NULL;
		(*arbol)->izq=NULL;
	}else if(num < (*arbol)->dato){
		Insertar(&(*arbol)->izq,num);
	}else if(num > (*arbol)->dato){
		Insertar(&(*arbol)->der,num);
	}
}
// Muestra el contenido del árbol en InOrden
void Mostrar(T_Arbol arbol){
	if(arbol!=NULL){
		Mostrar(arbol->izq);
		printf(" %d",arbol->dato);
		Mostrar(arbol->der);
	}

}
// Guarda en disco el contenido del fichero
void Salvar(T_Arbol arbol, FILE* fichero){

	if(arbol!=NULL){
		Salvar(arbol->izq,fichero);
		fwrite(&(arbol->dato),sizeof(int),1,fichero);
		Salvar(arbol->der,fichero);
	}

}
