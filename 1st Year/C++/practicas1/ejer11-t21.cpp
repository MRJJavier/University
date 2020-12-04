#include <iostream>
using namespace std;
/*José Javier Morente Risco. 23 de octubre de 2017. Practicas de FP*/
const float TEORIA=0.7;
const float PROBLEMAS=0.3;
int main(){
float notateoria,notaproblemas,notatotal;
cout << "Inserte la nota de la parte de teoria: ";
cin >> notateoria;
cout << "Inserte la nota de la parte de problemas: ";
cin >> notaproblemas;
notatotal=notateoria*TEORIA+notaproblemas*PROBLEMAS;
cout << "La nota final de la asignatura es: " << notatotal;

return 0;
}
