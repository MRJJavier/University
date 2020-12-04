#include <iostream>
using namespace std;
/*José Javier Morente Risco. 23 de octubre de 2017. Practicas de FP*/
const unsigned MAYUSCULA=32;
int main(){
char letra1,letra2,letra3,letra4;
cout << "Inserte una palabra de cuatro letras MINUSCULAS: ";
cin >> letra1 >> letra2 >> letra3 >> letra4;
cout <<"La palabra de cuatro letras escrita en MAYUSCULAS: ";
cout << char(int(letra1)-MAYUSCULA) << char(int(letra2)-MAYUSCULA) << char(int(letra3)-MAYUSCULA) << char(int(letra4)-MAYUSCULA);
return 0;
}
