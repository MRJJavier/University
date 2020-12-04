#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 8-11-2017. Fundamentos de la Programación T2 adicional
//n es el numero a pasar a binario y k el numero de 1s consecutivos que queremos saber si tiene n, devolviendo el programa si o no
const unsigned PBINARIO=2;
int main(){
    unsigned k,n,cont;
    cont=0;
    cout<<"Introduzca un numero natural: ";
    cin>>n;
    cout<<"Introduzca un numero para saber si "<<n<<" tiene esa cantidad de 1s consecutivos en binario: ";
    cin>>k;

    while((n!=0)&&(cont!=k))
    {

        if(n%PBINARIO==1)
        {
            cont++;
        }
        else
        {
            cont=0;
        }
    n/=PBINARIO;
    }

    if(cont==k)
    {
        cout<<"Si";
    }
    else
    {
        cout<<"No";
    }
return 0;
}
