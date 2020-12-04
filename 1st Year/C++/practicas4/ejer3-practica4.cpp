#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 3/12/2017
//Ejercicio 3 COMPLETO. PARTE A y PARTE B

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
int sumatoriadivisores(int n)
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
    sumatoria+=n;
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
int menor(int n,int m)
{
    int guarda;
    if(n>m)
    {
        guarda=m;
        m=n;
        n=guarda;
    }
    return n;
}
int mayor(int n,int m)
{
    int guarda;
    if(n>m)
    {
        guarda=m;
        m=n;
        n=guarda;
    }
    return m;
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

void parejasdeamigos(int n,int m)
{
    int cont,guarda;
    cont=n;
    while(cont<m)
    {

        if((sumatoria(cont)<=m)&&(sumatoria(sumatoria(cont))==cont)&&(sumatoria(cont)!=cont))
        {
            cout<<cont<<" es amigo del "<<sumatoria(cont)<<endl;
            guarda=sumatoria(cont);
        }
        cont++;
        if(cont==guarda)
        {
            cont++;
        }
    }
}


int main()
{
    int a,b,n,m;
    cout<<"Ejercicio 3. Parte A"<<endl;
    a=llamarnumero(a);
    b=llamarnumero(b);
    compararsumatorio(sumatoria(a),a,sumatoria(b),b);

    cout<<"Ejercicio 3. Parte B"<<endl;
    n=llamarnumero(n);
    m=llamarnumero(m);
    parejasdeamigos(menor(n,m),mayor(n,m));

    return 0;
}
