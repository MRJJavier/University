#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 29/11/2017
int primosbuscar(int N)
{
    do
    {
        cout<<"Introduce el numero de numeros primos a buscar: ";
        cin>>N;
    }while(N<0);

    return N;
}
bool esPrimo(int cont)
{
    unsigned divisor;
    divisor=2;

    while((divisor<cont)&&(cont%divisor!=0))
    {
        divisor++;
    }
    return divisor>=cont;
}
void nprimos(int N)
{
    cout<<"Los "<<N<<" primeros numeros primos son: ";
    int cont,primcont;
    cont=2;
    primcont=0;
    while(primcont<N)
    {
        if(esPrimo(cont))
        {
            cout<<cont<<" ";
            primcont++;
        }
        cont++;
    }
}

int main()
{
    int N;
    nprimos(primosbuscar(N));
    return 0;
}
