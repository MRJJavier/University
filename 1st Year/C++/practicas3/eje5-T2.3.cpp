#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Se introduce un valor n que nos indica las n primeras fracciones a tomar y se realiza un for para la sumatoria y ademas if y else dentro del for para ir aumentando el valor del numerador y denominador de las funciones
const unsigned SECUENCIA=2;
int main(){
    unsigned n;
    float pi,numerador,denominador;
    cout<<"Introduce un valor n: ";
    cin>>n;
    numerador=2;
    denominador=1;
    pi=2;
    for(unsigned cont=0;cont<=n;cont++)
    {
        pi*=(numerador/denominador);
        if(cont%2==0)
        {
            denominador+=SECUENCIA;
        }
        else
        {
            numerador+=SECUENCIA;
        }
    }
    cout<<"El valor de PI con n="<<n<<" es aproximadamente: "<<pi<<endl;

return 0;
}
