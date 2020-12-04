#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 8-11-2017. Fundamentos de la Programación T2 adicional
//Se realiza la sumatoria de (n/2^n) donde n es el limite superior de la sumatoria y cont es valor inicial del limite inferior
const unsigned BASE=2;
int main(){
    unsigned n;
    float s,p;
    cout<<"Introduce un numero natural: ";
    cin>>n;
    s=0;
    p=BASE;
    for(float cont=1;cont<=n;cont++)
    {
        s+=(cont/p);
        p*=BASE;
    }

    cout<<"El valor de S para "<<n<<" es: "<<s;
return 0;
}
