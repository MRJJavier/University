package dyvPar19;

public class dyvPar19 {

	public static int MenorOmitidoFB(int[] v) {
		int i=0;
		while(i < v.length && i==(v[i]-v[0])) i++;
		return v[i-1]+1;
	}
	
	public static int MenorOmitidoDyV(int[] v) {
		return MenorOmitidoRec(v,0,v.length-1);
	}
	
	public static int MenorOmitidoRec(int[] v, int izq, int der) {
		int omitido;
		int med = (izq+der)/2;
		
		if((v[med] - v[izq]) > (med-izq)) {
			omitido = MenorOmitidoRec(v,izq,med-1);
		}else if ((v[der]-v[izq]) == der || (v[der]-v[izq]) == 0) {
			omitido = v[der]+1;
		}else {
			omitido = MenorOmitidoRec(v,med,der);
		}
		
		return omitido;
	}
	
	public static void main(String args[]) {
		
		int A[] = {21,22,24,28,36,37};
		System.out.println("El número que falta FB es "+MenorOmitidoFB(A));
		System.out.println("El número que falta es "+MenorOmitidoDyV(A));
		int B[] = {21,22,23,24,25,26};
		System.out.println("El número que falta FB es "+MenorOmitidoFB(B));
		System.out.println("El número que falta es "+MenorOmitidoDyV(B));
		int C[] = {21,22,23,25,26,27};
		System.out.println("El número que falta FB es "+MenorOmitidoFB(C));
		System.out.println("El número que falta es "+MenorOmitidoDyV(C));
	}
}
