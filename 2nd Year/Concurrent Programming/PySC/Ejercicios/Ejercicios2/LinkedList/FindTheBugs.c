#include <stdio.h>
#include <stdlib.h>

#include "LinkedList.h"

int main001(){
    TList list;
	Create(&list);
    Insert(&list, 14);
    Insert(&list, 16);
    Insert(&list, 38);
    Insert(&list, 215);
    Show(list);
    Insert(&list, 3007);
    Show(list);
    Delete(&list);
    Show(list);
    Delete(&list);
    Delete(&list);
    Show(list);
    Destroy(&list);
    Show(list);


    return EXIT_SUCCESS;
}
