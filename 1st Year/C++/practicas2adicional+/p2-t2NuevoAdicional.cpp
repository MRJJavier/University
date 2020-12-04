#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 14-11-2017. Fundamentos de la Programación T2 nuevos adicionales
//Se introduce un numero real y se realiza la sumatoria para ese numero, el ultimo sumando es mayor que 0.0001
int main(){
    float sumatoria,numerador,denominador,cont,x;
    cout<<"Introduce un numero real: ";
    cin>>x;
    sumatoria=1;
    numerador=1;
    denominador=1;
    cont=0;
    while((numerador/denominador)>0.0001)
    {
        cont++;
        numerador*=x;
        denominador*=cont;
        sumatoria+=(numerador/denominador);
    }
    cout<<"EL valor de S del numero "<<x<<" es: "<<sumatoria;
return 0;
}
