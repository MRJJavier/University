package dyvFin18;

public class Fin18 {

	public static boolean hayOpuesto(int v[]) {
		return hayOpuestoRec(v,0,v.length-1);
	}
	//Supongo que estan ordenados crecientemente
	public static boolean hayOpuestoRec(int v[], int izq, int der) {
		if(izq <= der) {
			int med = (izq+der)/2;
			boolean opuesto;
			if(v[med]==0) {
				opuesto=false;
			}else if(v[med]>0) {
				if(izq <= med-1 && v[med-1]+v[med]==0) opuesto=true;
				else opuesto = hayOpuestoRec(v,izq,med-1);
			}else {
				if(med+1 <= der && v[med+1]+v[med]==0) opuesto=true;
				else opuesto = hayOpuestoRec(v,med+1,der);
			}
			return opuesto;
		}else {
			return false;
		}
	}
	
	public static void main(String[] args) {
		
		int v[]= {-3,-2,2,-3};
		
		System.out.println("Hay opuestos?: "+hayOpuesto(v));
	}
}
