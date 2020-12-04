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
unsigned inversoRec(unsigned x,unsigned n)
{
    int inver;
    inver=0;

    if(x<=9)
    {
        inver=x;
    }
    else
    {
        inver=(x%10)*potencia(10,n-1)+inversoRec(x/10,n-1);

    }
    return inver;
}
void inverso(unsigned x)
{
    int n,aux;
    aux=x;
    n=0;
    while(aux!=0)
    {
        aux/=10;
        n++;
    }
    cout<<"El inverso es: "<<inversoRec(x,n);
}
int main()
{
    int x;
    x=llamarnumero(x);
    inverso(x);

    return 0;
}
