#include <iostream>
using namespace std;
/*José Javier Morente Risco. 23 de octubre de 2017. Practicas de FP*/
const unsigned MINUTOS=60;
const unsigned HORAS=60*60;
const unsigned DIAS= 24*60*60;
const unsigned SEMANAS=7*24*60*60;
int main(){
unsigned natural,semana,dia,hora,minuto,segundo;
cout << "Inserte el numero de segundos a convertir: ";
cin >> natural;
semana=natural/SEMANAS;
dia=natural%SEMANAS/DIAS;
hora=natural%SEMANAS%DIAS/HORAS;
minuto=natural%SEMANAS%DIAS%HORAS/MINUTOS;
segundo=natural%SEMANAS%DIAS%HORAS%MINUTOS;
cout << natural <<" segundos son: " << semana << " semanas, " << dia <<" dias, " << hora << " horas, " << minuto << " minutos y " << segundo << " segundos." << endl;
return 0;
}
