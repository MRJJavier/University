#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 3/12/2017
//Ejercicio 6. Relacion 2. Conjetura de Goldbach
int llamarlimite(int n)
{
    do
    {
        cout<<"Introduzca un limite: ";
        cin>>n;
    }
    while(n<0);
    return n;
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
bool dsumprimos(int n)
{
    int cont,cont1,sum;
    cont=0;
    cont1=0;
    sum=0;

    while((cont<n)&&(sum!=n))
    {
        cont++;

        if((esPrimo(cont))&&(cont!=1))
        {
            sum+=cont;
            cont1=0;
            while((cont1<n)&&(sum!=n))
            {
                cont1++;
                if(esPrimo(cont1)&&(cont1!=1))
                {
                    sum+=cont1;
                    if(sum!=n)
                    {
                        sum=cont;
                    }
                }
            }
            if(sum!=n)
            {
                sum=0;
            }
        }
    }
    return sum==n;
}
void conjetura(int limI,int limS)
{
    int cont;
    bool sumatoria2primos;
    cont=limI;
    sumatoria2primos=true;
    while((cont<=limS)&&(sumatoria2primos!=false))
    {
        if(cont%2==0)
        {
            sumatoria2primos=(dsumprimos(cont));
        }
        cont++;
    }

    if(sumatoria2primos)
    {
        cout<<"Todos los pares en el rango elegido cumplen la conjetura"<<endl;
    }
    else
    {
        cout<<"NO todos los pares en el rango elegido cumplen la conjetura"<<endl;
    }
}
int main()
{
    int lim1,lim2;
    lim1=llamarlimite(lim1);
    lim2=llamarlimite(lim2);
    conjetura(menor(lim1,lim2),mayor(lim1,lim2));

    return 0;
}
