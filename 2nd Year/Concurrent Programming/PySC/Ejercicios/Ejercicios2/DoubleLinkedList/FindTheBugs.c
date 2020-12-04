#include <stdio.h>
#include <stdlib.h>

#include "DoubleLinkedList.h"

int main002(int argc, char** argv) {
    TList plist[7];
    Create(plist);
    int i;
    int data1[7]={1,5,4,7,2,3,6};
    int data2[7]={14,13,12,11,10,9,8};
    printf("Introduciré los siguientes datos: ");
    for(i=0;i<7;i++){
    	printf("%d ",data1[i]);
    	Add(plist,data1[i]);
    }
    printf("\nMostraré la lista ordenada\n");
    Show(*plist);
    printf("Destruiré la lista.");
    Destroy(plist);
    Show(*plist);
    printf("Lista destruida.");

    printf("\n***************\n");

    printf("Introduciré los siguientes datos: ");
       for(i=0;i<7;i++){
       	printf("%d ",data2[i]);
       	Add(plist,data2[i]);
       }
       printf("\nMostraré la lista ordenada\n");
       Show(*plist);
       printf("Destruiré la lista.");
       Destroy(plist);
       Show(*plist);
       printf("Lista destruida.");

    return EXIT_SUCCESS;
}
