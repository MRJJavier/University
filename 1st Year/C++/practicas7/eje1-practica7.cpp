#include <iostream>
using namespace std;
//Practica 7. Jose Javier Morente Risco. FP 8/1/2018
const unsigned N=4;
const unsigned M=3;
typedef int Tarray[N][M];

void leerArray(Tarray& ar)
{
    cout<<"ARRAY BIDIMENSIONAL DE "<<N<<" FILAS Y "<<M<<"COLUMNAS"<<endl;
    for(unsigned cont=0;cont<N;cont++)
    {
        for(unsigned cont1=0;cont1<M;cont1++)
        {
           cout<<"Inserta el valor para la fila "<<cont+1<<" columna "<<cont1+1<<" del array: ";
           cin>>ar[cont][cont1];
        }
    }
}
void Mayor(const Tarray& ar)
{
    int mayor,sN,sM;
    mayor=ar[0][0];
    sN=0;
    sM=0;
    for(unsigned cont=0;cont<N;cont++)
    {
        for(unsigned cont1=0;cont1<M;cont1++)
        {

            if(ar[cont][cont1]>mayor)
            {
                mayor=ar[cont][cont1];
                sN=cont;
                sM=cont1;
            }

        }
    }
    cout<<"El mayor valor de la matriz es "<<mayor<<" y se encuentra en la fila "<<sN+1<<" columna "<<sM+1<<"."<<endl;

}
int main(){
Tarray ar;
leerArray(ar);
Mayor(ar);

return 0;
}
