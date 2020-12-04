#include <iostream>
#include <string>
using namespace std;
//Jose Javier Morente Risco. Practica 8. 22/1/18
const int N=10;
unsigned potencia(unsigned u)
{
    unsigned pot;
    pot=1;
    for(unsigned cont=0;cont<u;cont++)
    {
        pot*=N;
    }
    return pot;
}
unsigned varUnsigned(string& salida)
{
    unsigned cont1,valor,pot,guarda;
    guarda=0;
    valor=0;
    cont1=salida.size()-1;

    for(unsigned cont=0;cont<=salida.size()-1;cont++)
    {
        pot=potencia(cont1);
        guarda=salida[cont];
        valor=valor+((guarda-48)*pot);
        cont1--;
    }
    return valor;
}
void pasarUnsigned(const string& entrada, string& salida)
{
    unsigned valor;
    for(unsigned cont=0;cont<=entrada.size()-1;cont++)
    {
        if(entrada[cont]!='-')
        {
            salida+=entrada[cont];
        }
    }
    valor=varUnsigned(salida);
    cout<<"Salida: "<<valor<<endl;
}

int main(){
unsigned valor;
string entrada,salida;
cout<<"Entrada: ";
cin>>entrada;
pasarUnsigned(entrada,salida);

return 0;
}
