////////////////////////////////////////////////////////////////////////////////////////////
// ALUMNO: José Javier Morente Risco
// GRUPO: 2ºC
////////////////////////////////////////////////////////////////////////////////////////////

public class OrdenacionRapida extends Ordenacion {
  
	public static <T extends Comparable<? super T>> void ordenar(T v[]) {
	    ordRapidaRec(v, 0, v.length-1);
	}

	// Debe ordenar ascendentemente los primeros @n elementos del vector @v con 
	// una implementaci�n recursiva del m�todo de ordenaci�n r�pida.	
	public static <T extends Comparable<? super T>> void ordRapidaRec(T v[], int izq, int der) {
	    // A completar por el alumno
		if(izq < der) {
			int s=partir(v,v[izq],izq,der);
			ordRapidaRec(v,izq,s);
			ordRapidaRec(v,s+1,der);
		}	
	}
	
   public static <T extends Comparable<? super T>> int partir(T v[], T pivote, int izq, int der) {
	    // A completar por el alumno
	   int i=izq-1;
	   int j=der+1;
	   while(i<j) {
		   do {
			   j--;
		   }while(v[j].compareTo(pivote)>0);
		   do {
			   i++;
		   }while(v[i].compareTo(pivote)<0);
		   if(i<j) {
			   T aux=v[i];
			   v[i]=v[j];
			   v[j]=aux;
		   }
	   }
	    return j;    	
   }

	// Peque�os ejemplos para pruebas iniciales.
	public static void main (String args[]) {
	
		// Un vector de enteros
		Integer vEnt[] = {3,8,6,5,2,9,1,1,4};
		OrdenacionRapida.ordenar(vEnt);
		System.out.println(vectorAString(vEnt));

		// Un vector de caracteres
		Character vCar[] = {'d','c','v','b'};
		OrdenacionRapida.ordenar(vCar);
		System.out.println(vectorAString(vCar));

	}	
    
}
