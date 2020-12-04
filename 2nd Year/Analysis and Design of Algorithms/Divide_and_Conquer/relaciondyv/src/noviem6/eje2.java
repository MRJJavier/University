package noviem6;

public class eje2 {
	
	private static void intercambia(int[]v, int pri, int ult, int k) {
		int posPri=pri;
		int posUlt=(ult+1)-k;
		while((posPri<pri+k)&&posUlt<(ult+1)) {
			int aux =v[posPri];
			v[posPri]=v[posUlt];
			v[posUlt]=aux;
			posPri++;
			posUlt++;
		}
	}
	
	private static int[] trasponer(int[] v, int pri, int ult, int k) {
		if((ult-pri)+1<k) return v;
		if((ult-pri)+1==2*k) {
			intercambia(v,pri,ult,k);
			return v;
		}
		if((ult-pri)+1>2*k) {
			intercambia(v,pri,ult,k);
			return trasponer(v,pri,ult-k,k);
		}
		if((ult-pri)+1<2*k) {
			k=(ult+1)-k;
			intercambia(v,pri,ult,k);
			if(k==2) return trasponer(v,pri+k,ult,k);
			else return trasponer(v,pri,ult-k,k);
		}
		return v;
	}
}
