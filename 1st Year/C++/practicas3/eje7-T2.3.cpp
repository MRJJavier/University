#include <iostream>
using namespace std;
//Jose Javier Morente Risco. 16-11-2017. Fundamentos de la Programación T2 Practica 3
//Uso un bucle while con sentencias if y else y dentro de la if un switch para realizar el tipo de operacion introducida.Se diferencia del anterior en que acaba el programa usando throw si no se usa una operacion permitida
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
            cout<<"Operacion no existente"<<endl;
            throw "";
        }

        cout<<"Operacion: ";
        cin>>operacion;

    }
    cout<<"FIN DEL PROGRAMA"<<endl;

return 0;
}
