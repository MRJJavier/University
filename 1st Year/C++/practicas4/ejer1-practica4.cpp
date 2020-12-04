#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 27/11/2017
int altura(int al)
{
    do
    {
        cout<<"Introduce la altura de la piramide: ";
        cin>>al;
    }while((al<0)||(al>=10));

    return al;
}
int escribeBlancos(int fila, int al)
{
    for(int cont=1;cont<=al-fila;cont++)
    {
        cout<<" ";
    }
}
int escribeNumCrec(int fila, int al)
{
    for(int cont=1;cont<=al-(al-fila);cont++)
    {
        cout<<cont;
    }
}
int escribeNumDecrec(int fila, int al)
{
    for(int cont=al-(al-fila)-1;0<cont;cont--)
    {
        cout<<cont;
    }
}
void piramide(int al)
{
    for(int cont=1;cont<=al;cont++)
    {

        escribeBlancos(cont,al);
        escribeNumCrec(cont,al);
        escribeNumDecrec(cont,al);
        cout<<endl;

    }
}
int main()
{
    int al;
    piramide(altura(al));


    return 0;
}
