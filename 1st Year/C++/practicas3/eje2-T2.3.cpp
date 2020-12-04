#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Se introduce el numero de modelos y con un for se introduce sus precios que se suman y finalmente se divide por el numero de modelos
int main(){
    unsigned num;
    float precio,suma;
    suma=0;

    cout<<"Introduzca numero de modelos de coche: ";
    cin>>num;

    for(unsigned cont=1;cont<=num;cont++)
    {
        cout<<"Precio modelo "<<cont<<": ";
        cin>>precio;
        suma+=precio;
    }
    cout<<"El valor medio de los "<<num<<" modelos de coche asciende a: "<<(suma/num)<<" euros"<<endl;
return 0;
}
