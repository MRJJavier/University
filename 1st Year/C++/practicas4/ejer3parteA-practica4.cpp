#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 1/12/2017
int llamarnumero(int n)
{
    do
    {
        cout<<"Inserte un numero natural: ";
        cin>>n;
    }
    while(n<0);
    return n;
}
int sumatoria(int n)
{

    unsigned divisor,sumatoria;
    divisor=1;
    sumatoria=0;
    while(divisor<n)
    {
              if(n%divisor==0)
              {
                  sumatoria+=divisor;

              }
              divisor++;

    }
    return sumatoria;

}
void compararsumatorio(int sumA,int a,int sumB,int b)
{
    if((sumA==b)&&(sumB==a))
    {
        cout<<"Los numeros son amigos"<<endl;
    }
    else
    {
        cout<<"Los numeros NO son amigos"<<endl;
    }
}

int main()
{
    int a,b;
    cout<<"Ejercicio 3. Parte A"<<endl;
    a=llamarnumero(a);
    b=llamarnumero(b);
    compararsumatorio(sumatoria(a),a,sumatoria(b),b);
    return 0;
}
