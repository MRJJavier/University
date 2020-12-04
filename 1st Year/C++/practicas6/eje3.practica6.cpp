#include <iostream>
using namespace std;
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

void mostrararray(const Tarray& ar)
{
    for(unsigned cont=0;cont<MAX;cont++)
    {
        cout<<"El digito "<<cont<<" se repite "<<ar[cont]<<" veces"<<endl;
    }
}
int main(){
Tarray ar;
seteararray(ar);
valoresarray(ar);
mostrararray(ar);

return 0;
}
