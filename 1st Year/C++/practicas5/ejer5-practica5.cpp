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
bool esprimoRec(unsigned n,unsigned div)
{
    if((n%div!=0)&&(n!=div+1))
    {
        esprimoRec(n,div+1);
    }
    if(n%div==0)
    {
        div=n;
    }

   return div!=n;


}
void primo(unsigned n)
{
    unsigned div;
    div=2;
    if(esprimoRec(n,div))
    {
        cout<<"Es primo"<<endl;
    }
    else
    {
        cout<<"No es primo"<<endl;
    }
}
int main()
{
    int n;

    primo(llamarnumero(n));

    return 0;
}

