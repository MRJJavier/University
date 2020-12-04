#include <iostream>
using namespace std;
//Practica 6. Jose Javier Morente Risco. FP 21/12/2017
const unsigned MAX=50;
typedef unsigned Tarray[MAX];
struct Testaturas
{
    Tarray estatura;
    int tam;
};

void escribirVector(Testaturas& v)
{
    do{
    cout<<"Escribe el tamano del array: ";
    cin>>v.tam;
    }while((v.tam>50)||(v.tam<=0));

    cout<<"Introduce la estatura en centimetros del alumno"<<endl;
    for(unsigned cont=0;cont<v.tam;cont++)
    {
        cout<<"Introduce la estatura del alumno "<<cont+1<<": ";
        cin>>v.estatura[cont];
    }
}
float media(const Testaturas& v)
{
    float med;
    med=0;
    for(unsigned cont=0;cont<v.tam;cont++)
    {
        med+=v.estatura[cont];
    }
    med/=v.tam;
    return med;
}
unsigned masaltos(float med,const Testaturas& v)
{
    unsigned altos;
    altos=0;
    for(unsigned cont=0;cont<v.tam;cont++)
    {
        if(med<v.estatura[cont])
        {
           altos++;
        }
    }
    return altos;
}
unsigned masbajos(float med,const Testaturas& v)
{
    unsigned bajos;
    bajos=0;
    for(unsigned cont=0;cont<v.tam;cont++)
    {
       if(med>v.estatura[cont])
       {
           bajos++;
       }
    }
    return bajos;
}

int main()
{
Testaturas v;
float med;
unsigned altos,bajos;
escribirVector(v);
med=media(v);
altos=masaltos(med,v);
bajos=masbajos(med,v);
cout<<"La media de las alturas es: "<<med<<endl;
cout<<"Hay "<<altos<<" alumnos mas altos que la media"<<endl;
cout<<"Hay "<<bajos<<" alumnos mas bajos que la media"<<endl;

return 0;
}

