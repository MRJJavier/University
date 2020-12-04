#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 11-11-2017. Fundamentos de la Programación T2 adicional

int main(){

    unsigned n,provincia,operacion,control;
    cout<<"Escriba un codigo de cuatro digitos: ";
    cin>>n;
    provincia=n/1000;
    operacion=(n%1000)/10;
    control=n%10;
    if((n<1000)||(n>9999)||((operacion/provincia)!=control))
    {
        cout<<"ERROR: CODIGO INVALIDO"<<endl;
    }
    else
    {
        cout<<"Provincia: "<<provincia<<endl;
        cout<<"Numero de operacion: "<<operacion<<endl;
        cout<<"Digito de control: "<<control<<endl;
    }
return 0;
}
