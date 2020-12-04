#include <iostream>
using namespace std;
//Practica 7. Jose Javier Morente Risco 14/1/18
const unsigned N=5;
typedef unsigned Tarray[N][N];

void leerArray(Tarray& ar)
{
    cout<<"Inserte los valores del cuadrado."<<endl;
    for(unsigned cont=0;cont<N;cont++)
    {
        for(unsigned cont1=0;cont1<N;cont1++)
        {
            cin>>ar[cont][cont1];
        }
    }
}

bool esMagico(const Tarray& ar)
{
    bool magico;
    unsigned suma,comprobar,cont,cont1;
    magico=true;

    suma=0;
    cont=0;
    cont1=0;
    //Suma diagonal
    while((cont<N)&&(cont1<N))
    {
        suma+=ar[cont][cont1];
        cont++;
        cont1++;
    }

    comprobar=0;
    cont=0;
    cont1=4;
    //Suma diagonal inversa
    while((cont<N)&&(cont1>=0))
    {
        comprobar+=ar[cont][cont1];
        cont++;
        cont1--;
    }

    //Comprueba ambas diagonales
    if(suma==comprobar)
    {
        //Compruebo filas con valor de la diagonal
        comprobar=0;
        cont=0;
        cont1=0;
        while((cont<N)&&(magico==true))
        {
            while(cont1<N)
            {
                comprobar+=ar[cont][cont1];
                cont1++;
            }
            if(comprobar!=suma)
            {
                magico=false;
            }
            comprobar=0;
            cont1=0;
            cont++;
        }
        //Compruebo si sigue siendo verdadero, para comparar o no las columnas
        if(magico==true)
        {
            comprobar=0;
            cont=0;
            cont1=0;
            //Compruebo columnas con el valor de la diagonal
            while((cont<N)&&(magico==true))
            {
                while(cont1<N)
                {
                    comprobar+=ar[cont1][cont];
                    cont1++;
                }
                if(comprobar!=suma)
                {
                magico=false;
                }
                comprobar=0;
                cont1=0;
                cont++;
            }
        }
    }
    else
    {
        magico=false;
    }


    return magico;
}

int main(){
Tarray ar;
leerArray(ar);
if(esMagico(ar))
{
    cout<<"El cuadrado es magico."<<endl;
}
else
{
    cout<<"El cuadrado NO es magico."<<endl;
}



return 0;
}
