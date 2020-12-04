package dyvFin19S;

public class dyvFin19S {

	public static int FindFirstFB(int[] v, int e) {
		int indice=0;
		while(indice<v.length && v[indice]!=e) indice++;
		return indice;
	}
	
	public static int FindFirstDyV(int[] v, int e) {
		return FindFirstDyVRec(v,0,v.length-1,e);
	}
	
	public static int FindFirstDyVRec(int[] v, int izq, int der, int e) {
		int indice;
		if(izq <= der) {
			int med = (izq+der)/2;
			if(v[med]==e && izq==der) {
				indice=med;
			}else if(v[med]>=e) {
				indice=FindFirstDyVRec(v,izq,med,e);
			}else {
				indice=FindFirstDyVRec(v,med+1,der,e);
			}
		}else {
			indice=-1;
		}
		return indice;
	}
	
	public static void FindFirstCoinciden(int fb, int dyv) {
		boolean coinciden = (fb==dyv)? true:false;
		System.out.println("Ambos algoritmos coinciden?: "+coinciden);
	}
	public static void main(String args[]) {
		int v[] = {2,2,3, 3, 5, 5, 5, 5, 7, 9};
		int e = 3;
		int fb = FindFirstFB(v,e);
		int dyv = FindFirstDyV(v,e);
		System.out.println("FindFirstFB: "+fb);
		System.out.println("FindFirstDyV: "+dyv);
		FindFirstCoinciden(fb,dyv);
		
	}
}
