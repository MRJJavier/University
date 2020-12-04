

#include <stdio.h>

int main4(){
    int n=-8;
    printf("%d\n",n);
    printf("%u\n",n);
    char a;
    unsigned char b;
    a='A';
    b='B';
    printf("%c %c %d\n",a,b,a,b);
    a=183;
    b=255;
    printf("%d %d\n",a,b); // -73 255
    int m= 0xC2ED400; // 1100 0010 1110 1101 0100 0000 0000 0000
    printf("%u\n",m);
    printf("%d\n",m);
    printf("%x\n",m);
    printf("%o\n",m);
    printf("%f\n",*((float*)&m));
    printf("%d %d %d %d",sizeof(char), sizeof(int), sizeof(float), sizeof(double));
    return 0;

}
