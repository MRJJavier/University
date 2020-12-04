
#ifndef DOUBLELINKEDLIST_H
#define	DOUBLELINKEDLIST_H

#include <stdio.h>
#include <stdlib.h>

typedef struct Node * TList;
typedef struct Node {
    int data;
    struct Node *next;
    struct Node *prev;
} TNode;

/* Creates an empty List */
void Create(TList * plist);

/* Insert in the list in an ordered way */
void Add(TList * plist, int data);

/* Displays the content of the list */
void Show(TList plist);

/* Destroys the list and sets it to NULL */
void Destroy(TList * plist);


#endif	/* DOUBLELINKEDLIST_H */

