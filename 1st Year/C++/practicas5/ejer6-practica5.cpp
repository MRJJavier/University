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
unsigned contBINARIO(unsigned n)
{
    int cont=0;
    while(n!=0)
    {
        n/=2;
        cont++;
    }
    return cont;
}
unsigned contDECIMAL(unsigned n)
{
    int cont=0;
    while(n!=0)
    {
        n/=10;
        cont++;
    }
    return cont;
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
unsigned decimalAbinarioRec(unsigned n,unsigned cont)
{
    unsigned num,k,aux;
    num=0;

    if(cont==0)
    {
        num+=n%2;
    }
    else
    {
        num+=(n%2)*potencia(10,cont-1)+decimalAbinarioRec(n/2,cont-1);
    }
    return num;
}
void decimalAbinario(unsigned n)
{
    int cont,cont1;
    cont=contBINARIO(n);
    n=decimalAbinarioRec(n,cont);
    cont1=contDECIMAL(n);
    n=inversoRec(n,cont1);
    cout<<n<<endl;

}
int main()
{
    int n;
    n=llamarnumero(n);
    decimalAbinario(n);
}
