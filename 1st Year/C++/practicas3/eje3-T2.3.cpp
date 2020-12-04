#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Uso bucles for anidados y sentencias if y else para que al ejecutar el programa muestre un tablero de ajedrez
int main(){
    unsigned f,c;
    f=7;
    c=7;
    for(unsigned cont1=0;cont1<=f;cont1++)
    {
        if(cont1%2==0)
        {
             for(unsigned cont2=0;cont2<=c;cont2++)
            {
                if(cont2%2==0)
                {
                    cout<<" B ";
                }
                else
                {
                    cout<<" N ";
                }
            }
        }
        else
        {
            for(unsigned cont2=0;cont2<=c;cont2++)
            {
                if(cont2%2==0)
                {
                    cout<<" N ";
                }
                else
                {
                    cout<<" B ";
                }
            }
        }
        cout<<endl;
    }
return 0;
}
