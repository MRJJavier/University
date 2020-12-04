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
unsigned producto(unsigned x,unsigned y)
{
    unsigned pro;
    if(y==0)
    {
        pro=0;
    }
    else
    {
        pro=x+producto(x,y-1);
    }
    return pro;
}
int main()
{
    int y,x;
    x=llamarnumero(x);
    y=llamarnumero(y);
    cout<<x<<" multiplicado por "<<y<<" da como resultado "<<producto(x,y)<<endl;
    return 0;
}
