#include <iostream>
using namespace std;
/*José Javier Morente Risco. 23 de octubre de 2017. Practicas de FP*/
/*Si sumamos 1 + 3000000000 no sale el resutado que cabria esperar (3000000001) debido a
que el numero 3000000000 esta fuera del rango de int, habria que usar unsigned
para realizar esa operacion*/
int main(){
int natural1,natural2,suma;
cout << "Inserte el primer numero natural: ";
cin >> natural1;
cout << "Inserte el segundo numero natural: ";
cin >> natural2;
suma=natural1+natural2;
cout <<"La suma de " << natural1 << " + " << natural2 << " es igual a: " << suma << endl;

return 0;
}
