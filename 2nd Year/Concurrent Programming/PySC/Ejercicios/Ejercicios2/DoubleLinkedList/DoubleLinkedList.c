#include "DoubleLinkedList.h"
#include <stdio.h>
/* Creates an empty List */
void Create(TList * plist){
    *plist=NULL;
}

/* Insert in the list in an ordered way */
void Add(TList * plist, int data){
    TNode * ptr;
    TNode * aux;
    aux = (TNode *)malloc(sizeof(TNode));
    aux->data = data;
    aux->next = NULL;
    aux->prev = NULL;
    ptr = *plist;
    if(ptr == NULL){
        *plist = aux;
    } else {
        while((ptr->next != NULL) && (ptr->data <= data)){
        	ptr = ptr->next;
        }
        if(ptr->next == NULL && (ptr->data <= data)){
        	ptr->next = aux;
        	aux->prev = ptr;
        } else {
        	aux->next = ptr;
        	aux->prev = ptr->prev;
        	ptr->prev = aux;
        	if(aux->prev != NULL){
        		(aux->prev)->next=aux;
        	}else{
        		*plist = aux;
        	}

        }
    }
}

/* Displays the content of the list */
void Show(TList plist){
    while (plist != NULL){
        printf("%d ", plist->data);
        plist = plist->next;
    }
    printf("\n");
}


/* Destroys the list and sets it to NULL */
void Destroy(TList * plist){
    TList aux;
    while (*plist != NULL){
        aux = *plist;
        *plist = (*plist)->next;
        free(aux);
    }
    *plist = NULL;
}

