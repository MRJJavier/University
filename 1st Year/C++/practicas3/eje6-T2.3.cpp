#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 15-11-2017. Fundamentos de la Programación T2 Practica 3
//Uso un bucle while con sentencias if y else y dentro de la if un switch para realizar el tipo de operacion introducida
int main(){
    char operacion;
    int operando1,operando2;
    cout<<"Operacion: ";
    cin>>operacion;
    while(operacion!='&')
    {
        if((operacion=='+')||(operacion=='-')||(operacion=='*')||(operacion=='/'))
        {
            cout<<"Operando 1:";
            cin>>operando1;
            cout<<"Operando 2:";
            cin>>operando2;

            switch(operacion)
            {
                case '+':
                    cout<<"Resultado: "<<(operando1+operando2)<<endl;
                    break;
                case '-':
                    cout<<"Resultado: "<<(operando1-operando2)<<endl;
                    break;
                case '*':
                    cout<<"Resultado: "<<(operando1*operando2)<<endl;
                    break;
                default:
                    cout<<"Resultado: "<<(operando1/operando2)<<endl;
                    break;
            }
        }
        else
        {
            cout<<"ERROR!!!!"<<endl;
        }

        cout<<"Operacion: ";
        cin>>operacion;

    }
    cout<<"FIN DEL PROGRAMA"<<endl;

return 0;
}
