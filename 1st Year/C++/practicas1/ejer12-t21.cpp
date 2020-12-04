#include <iostream>
using namespace std;
/*José Javier Morente Risco. 23 de octubre de 2017. Practicas de FP*/
int main()
{
int a=6, b=14;
int auxiliar;
cout << "(Caso 1)\na vale " << a << " y b vale " << b << endl;
//Caso 1
// ¿Qué hacen estas tres sentencias?
// Dos de las variables (a y b) tienen datos que van a ser intercambiados,
// para ello se necesita una tercera variable (auxiliar), que permita guardar el dato de
// a en ella para poder asi sobrescribir la variable a con el dato b y finalmente se
// sobrescribe b con el dato guardado en la variable auxiliar, dando lugar al intercambio
auxiliar = a;
a = b;
b = auxiliar;
cout << "a vale " << a << " y b vale " << b << endl;
int a=6, b=14;
int auxiliar;
cout << "(Caso 2)\na vale " << a << " y b vale " << b << endl;
//Caso 2
// ¿Qué hacen estas tres sentencias?
//Se sobrescribe a con la suma de ella misma con b, se sobrescribe b restando la a obtenida
// menos la b dando lugar a que b tiene ahora el valor antiguo de a y finalmente a se
// sobrescribe con la resta de a menos b, dando lugar al valor antiguo de b, concluyendo
// el intercambio.
a = a + b;
b = a - b;
a = a - b;
cout << "a vale " << a << " y b vale " << b << endl;
//En ambos casos se produce el intercambio, sin embargo, las sentencias del
//caso 1 pueden ser utilizadas con otros tipos de variables como bool o char aparte de
// las numericas (int,unsigned,float), el caso 2 es util con las variables numericas pues
//realiza la misma funcion que el caso 1 y nos ahorramos de declarar una 3º variable.
return 0;
}
