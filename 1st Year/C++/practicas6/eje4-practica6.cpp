#include <iostream>
using namespace std;
//Practica 6. Jose Javier Morente Risco. FP 24/12/2017
const unsigned MAX=10;
typedef int Tarray[MAX];
void seteararray(Tarray& ar)
{
    for(unsigned cont=0;cont<MAX;cont++)
    {
        ar[cont]=0;
    }
}
void valoresarray(Tarray& ar)
{
    int valor;
    cout<<"Introduzca una secuencia de valores entre 0 y 9 (use un negativo para acabarla): ";
    do
    {
        cin>>valor;
        while(valor>9)
        {
            cin>>valor;
        }
        ar[valor]++;
    }
    while(0<=valor);
}
unsigned mayor(const Tarray& ar)
{
    unsigned mayor;
    mayor=0;
    for(unsigned cont=0;cont<MAX;cont++)
    {
        if(ar[cont]>=mayor)
        {
            mayor=ar[cont];
        }
    }
    return mayor;
}
void imprimirhistograma(unsigned mayor, const Tarray& ar)
{
    for(unsigned cont=mayor;cont>0;cont--)
    {
        for(unsigned cont1=0;cont1<MAX;cont1++)
        {
            if(ar[cont1]>=cont)
            {
                cout<<" * ";
            }
            else
            {
                cout<<"   ";
            }
        }
        cout<<endl;
    }
    for(unsigned cont=0;cont<MAX;cont++)
    {
        cout<<" "<<cont<<" ";
    }
}

int main(){
Tarray ar;
unsigned may;
seteararray(ar);
valoresarray(ar);
may=mayor(ar);
imprimirhistograma(may,ar);

return 0;
}
