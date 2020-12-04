import java.util.Random;

////////////////////////////////////////////////////////////////////////////////////////////
// ALUMNO: José Javier Morente Risco
// GRUPO: 2ºA
////////////////////////////////////////////////////////////////////////////////////////////

public class OrdenacionRapidaBarajada extends OrdenacionRapida {
	
	// Implementaci�n de QuickSort con reordenaci�n aleatoria inicial (para comparar tiempos experimentalmente)
	public static <T extends Comparable<? super T>> void ordenar(T v[]) {
		// A completar por el alumno
		barajar(v);
		OrdenacionRapida.ordenar(v);
    }

	// reordena aleatoriamente los datos de un vector
    private static <T> void barajar(T v[]) {
    	// A completar or el alumno
    	Random rng = new Random();
    	for(int i=0;i<v.length;i++) {
    		int pos=rng.nextInt(v.length);
    		T aux = v[i];
    		v[i]=v[pos];
    		v[pos]=aux;
    	}
    }	
	

}