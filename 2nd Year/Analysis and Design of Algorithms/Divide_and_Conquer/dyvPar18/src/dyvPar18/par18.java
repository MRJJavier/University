package dyvPar18;

public class par18 {
	
	// Función para encontrar el menor elemento omitido
	// en un array ordenado de naturales distintos
	public static int menorOmitidoRec(int[] a, int inf, int sup) {
		int minOmitido;
		// caso base
		if (a[inf] > inf) {
			minOmitido = inf;
		} else if ( a[sup] == sup ) {
			minOmitido = sup+1;
		} else {
			int med = (inf + sup) / 2;
			// si med coincide con su valor, el que falta  está¡ a la derecha
			if (a[med] == med) {
				minOmitido = menorOmitidoRec(a, med+1, sup);
			} else {
				// el que falta está¡ a la izquierda
				minOmitido = menorOmitidoRec(a, inf, med-1);
			}
		}
		return minOmitido;
	}
	
	/** Main */
	public static void main(String args[]) {
		int[] a = { 0, 1, 2, 4, 5, 6};
		
		System.out.println("El menor elemento omitido es " + menorOmitidoRec(a, 0, a.length -1));
	}		

}
