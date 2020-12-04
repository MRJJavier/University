#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 8-11-2017. Fundamentos de la Programación T2 adicional
// n es el natural que se eleva al cubo. Uso dos bucles for anidados, el primero para recorrer los valores de 1 a n y el segundo para realizar la secuencia de impares y que solo sume los impares cuando el en el primer bucle for el contador sea igual que n
const unsigned SECUENCIA=2;
int main(){
    unsigned n,i,s;
    cout<<"Introduce un numero natural: ";
    cin>>n;
    i=1;
    s=0;
    for(unsigned cont1=1;cont1<=n;cont1++)
    {
        if(cont1==n)
        {
            cout<<n<<" al cubo = ";
        }
        for(unsigned cont2=0;cont2<cont1;cont2++)
        {

            if((cont1==n)&&(cont2!=(cont1-1)))
            {
                s+=i;
                cout<<i<<" + ";

            }
            if((cont1==n)&&(cont2==(cont1-1)))
            {
                s+=i;
                cout<<i<<" = "<<s;
            }
            i+=SECUENCIA;
        }

    }
    return 0;
}
