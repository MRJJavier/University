#include <iostream>
using namespace std;
//Practica 6. Jose Javier Morente Risco. FP 24/12/2017
const unsigned MAX=100;
typedef int Tarray[MAX];

unsigned setearN(unsigned n)
{
do{}
cout<<"Introduce el tamaño del array (T.MAXIMO=100)";
cin>>n;
}while((n>0)&&(n<101));

}
void seteararray(Tarray& ar)
{
    for(unsigned cont=0;cont<MAX;cont++)
    {
        ar[cont]=0;
    }
}

int main(){
Tarray ar;
unsigned n;


return 0;
}
