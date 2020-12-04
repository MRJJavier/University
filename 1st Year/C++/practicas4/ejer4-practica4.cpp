#include <iostream>
using namespace std;
//Jose Javier Morente Risco. Fundamentos de la programacion Practica 4. 3/12/2017
int diagonal(int di)
{
    do
    {
        cout<<"Introduce la diagonal del rombo: ";
        cin>>di;
    }while(di<0);

    return di;
}
void escribeBlancos(int fila, int di)
{
    for(int cont=1;cont<=di-fila;cont++)
    {
        cout<<" ";
    }
}
void escribeAstCrec(int fila, int di)
{
    for(int cont=1;cont<=di-(di-fila);cont++)
    {
        if(cont%2!=0)
        {
            cout<<"*";
        }
        else
        {
            cout<<" ";
        }

    }
}
int escribeAstDecrec(int fila, int di)
{
    for(int cont=di-(di-fila)-1;0<cont;cont--)
    {
        if(cont%2!=0)
        {
            cout<<"*";
        }
        else
        {
            cout<<" ";
        }
    }
}
void rombo(int di)
{
    for(int cont=1;cont<=di;cont++)
    {

        escribeBlancos(cont,di);
        escribeAstCrec(cont,di);
        escribeAstDecrec(cont,di);
        cout<<endl;
    }
    for(int cont=di-1;1<=cont;cont--)
    {

        escribeBlancos(cont,di);
        escribeAstCrec(cont,di);
        escribeAstDecrec(cont,di);
        cout<<endl;
    }
}
int main()
{
    int di;
    di=diagonal(di);
    rombo(di);


    return 0;
}
