#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Se realiza la sumatoria S=1+2+...+N mediante las estructuras while, do while y for
int main(){
    unsigned n,cont,sumatoria;
    cout<<"Introduce un numero n entero positivo: ";
    cin>>n;
    sumatoria=0;
    for(unsigned cont=1;cont<=n;cont++)
    {
        sumatoria+=cont;
    }
    cout<<"La sumatoria de "<<n<<" usando la estructura FOR es: "<<sumatoria<<endl;
    if(sumatoria!=0)
    {
        cont=1;
        sumatoria=0;
    }

    while(cont<=n)
    {
        sumatoria+=cont;
        cont++;
    }
    cout<<"La sumatoria de "<<n<<" usando la estructura WHILE es: "<<sumatoria<<endl;
    if(sumatoria!=0)
    {
        cont=1;
        sumatoria=0;
    }

    do
    {
        sumatoria+=cont;
        cont++;
    }
    while(cont<=n);
    cout<<"La sumatoria de "<<n<<" usando la estructura DO-WHILE es: "<<sumatoria<<endl;




return 0;
}
