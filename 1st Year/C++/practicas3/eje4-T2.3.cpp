#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Uso cin.get para obtener cada caracter de car y un bucle while para mostrarlo en ASCII
int main(){
    char car;
    unsigned cont;
    cont=0;
    cout<<"Introduzca una secuencia de caracteres terminada en un punto: ";
    cin.get(car);
    while(car!='.')
    {
        cout<<"La posicion de "<<car<<" en la tabla ASCII es: "<<int(car)<<endl;
        cont++;
        cin.get(car);
    }
    cout<<"El numero total de caracteres leidos es: "<<cont<<endl;
return 0;
}
