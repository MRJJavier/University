#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 14-11-2017. Fundamentos de la Programación T2 nuevos adicionales
//Se introduce un numero natural y devuelve la raiz n-esima de dicho numero
int main(){
    unsigned num,n,x,mult;
    cout<<"Introduzca el numero: ";
    cin>>num;
    cout<<"Introduzca el valor n: ";
    cin>>n;
    x=2;
    mult=1;

    while(num>mult)
    {

            for(unsigned cont=1;cont<=n;cont++)
            {
               mult=mult*x;
            }
            if(num>mult)
            {
                x++;
                mult=1;
            }
            else
            {
                    x-=1;
            }
    }

    cout<<"La raiz n-esima de "<<num<<" es: "<<x<<endl;
return 0;
}
