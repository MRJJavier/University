
#ifndef LINKEDLIST_H
#define	LINKEDLIST_H

#include <stdio.h>
#include <stdlib.h>

typedef struct Node * TList;
typedef struct Node {
    int data;
    struct Node *next;
}TNode;

/* Creates an empty List */
void Create(TList * plist);

/* Insert in the head of the list */
void Insert(TList * plist, int data);

/* Displays the content of the list */
void Show(TList  plist);

/* Deletes the head of the list */
void Delete(TList * plist);

/* Destroys the list and sets it to NULL */
void Destroy();


#endif	/* LINKEDLIST_H */

