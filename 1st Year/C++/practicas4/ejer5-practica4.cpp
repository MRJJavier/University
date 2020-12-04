#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 3/12/2017
int altura(int al)
{
    do
    {
        cout<<"Introduce la altura de la piramide: ";
        cin>>al;
    }while(al<0);

    return al;
}
int escribeBlancos(int fila, int al)
{
    for(int cont=1;cont<=al-fila;cont++)
    {
        cout<<" ";
    }
}
int escribeNumCrec(int fila, int al,int enu)
{
    for(int cont=1;cont<=al-(al-fila);cont++)
    {
        cout<<enu;
        enu++;
        if (enu==10)
        {
            enu=0;
        }
    }
    return enu;

}
void escribeNumDecrec(int fila, int al,int enu)
{
    enu=enu-2;
    if(enu<0)
    {
        enu=8;
    }
    for(int cont=al-(al-fila)-1;0<cont;cont--)
    {
        cout<<enu;
        if(enu==0)
        {
            enu=10;
        }
        enu--;

    }
}
void piramide(int al)
{
    int enu;
    for(int cont=1;cont<=al;cont++)
    {
        enu=cont%10;
        escribeBlancos(cont,al);
        enu=escribeNumCrec(cont,al,enu);
        escribeNumDecrec(cont,al,enu);
        cout<<endl;

    }
}
int main()
{
    int al;
    piramide(altura(al));


    return 0;
}
