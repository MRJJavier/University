#include <iostream>
using namespace std;
//Practica 6. Jose Javier Morente Risco. FP 21/12/2017
const unsigned MAX=10;
typedef float Tarray[MAX];
void Datosarray(Tarray& ar)
{
    for(unsigned cont=0;cont<MAX;cont++)
    {
       cout<<"Introduce el valor para ar["<<cont<<"]: ";
       cin>>ar[cont];
    }
}
float mayor(const Tarray& ar)
{
    float may;
    may=0;
    for(unsigned cont=0;cont<MAX;cont++)
    {
        if(ar[cont]>=may)
        {
            may=ar[cont];
        }
    }
    return may;
}

int main(){
float m;
Tarray ar;
Datosarray(ar);
m=mayor(ar);
cout<<"El mayor valor del array es: "<<m;

return 0;
}
