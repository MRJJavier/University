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
    while(n<=0);
    return n;


}
unsigned potencia(unsigned x,unsigned n)
{
    unsigned pot;
    if(n==0)
    {
        pot=1;
    }
    else
    {
        pot=x*potencia(x,n-1);
    }

    return pot;
}
int main()
{
    int n,x;
    x=llamarnumero(x);
    n=llamarnumero(n);
    cout<<x<<" elevado a "<<n<<" es "<<potencia(x,n)<<endl;



    return 0;
}
