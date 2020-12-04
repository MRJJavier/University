#include <iostream>
using namespace std;
//Practica 7. Jose Javier Morente Risco. FP 8/1/2018
const unsigned N=4;
const unsigned M=4;
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
bool esSimetrica(const Tarray& ar)
{
    bool simetrica;
    unsigned cont,cont1,m;
    simetrica=true;
    cont=0;
    cont1=1;
    m=cont1;
    while((cont!=3)&&(cont1!=4)&&(simetrica==true))
    {
        while((m<4)&&(simetrica==true))
        {

            if(ar[cont][m]!=ar[m][cont])
            {
                simetrica=false;
            }
            else
            {
                m++;
            }
        }
        cont++;
        cont1++;
        m=cont1;
    }
    return simetrica;

}

int main(){
Tarray ar;
leerArray(ar);
if(esSimetrica(ar))
{
    cout<<"La matriz es simetrica"<<endl;
}
else
{
    cout<<"La matriz NO es simetrica"<<endl;
}

return 0;
}
