#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 5. 11/12/2017
unsigned llamarnumero(unsigned n)
{
    do
    {
    cout<<"Inserte un numero natural: ";
    cin>>n;
    }
    while(n<0);
    return n;
}
unsigned sumanaturales(unsigned n)
{
    unsigned sum;
    if(n==0)
    {
        sum=0;
    }

    else
    {
        sum=n+sumanaturales(n-1);
    }



    return sum;
}
int main()
{
    unsigned n;
    n=llamarnumero(n);
    cout<<"La suma de los primeros "<<n<<" naturales es: "<<sumanaturales(n)<<endl;


    return 0;
}
