#include "LinkedList.h"

#include <stdio.h>
/* Creates an empty List */
void Create(TList * plist){
    *plist=NULL;
}

/* Insert in the head of the list */
void Insert(TList * plist, int data){
	TList act= *plist;
	TList ant=NULL;
	TList aux = (TList) malloc(sizeof(struct Node));
	aux->data=data;
	while(act!=NULL){
		ant=act;
		act=act->next;
	}
	if(ant==NULL && act==NULL){
		aux->next = NULL;
		*plist = aux;
	}else{
		ant->next = aux;
				aux->next = NULL;
	}
}
/* Displays the content of the list */
void Show(TList  plist){
	printf("\n");
    while (plist != NULL){
        printf("%d ", plist->data);
        plist = plist->next;
    }
    printf("\n");
}

/* Deletes the head of the list */
void Delete(TList * plist){
    TList aux = *plist;
    *plist = (*plist)->next;
    free(aux);
}

/* Destroys the list and sets it to NULL */
void Destroy(TList * plist){
    TList aux;
    while (*plist != NULL){
        aux = *plist;
        *plist = (*plist)->next;
        free(aux);
    }
    *plist=NULL;
}

