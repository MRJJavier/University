package noviem6;

public class eje4 {

	private static int subSumMax(int[] v, int prim, int ult) {
		if(prim==ult) return v[prim];
		int medio=(prim+ult)/2;
		int sumI=subSumMax(v,prim,medio);
		int sumD=subSumMax(v,medio+1,ult);
		int i=medio, sumTempI=0, sum=0;
		while(i>=0) {
			if(sum+v[i]>sumTempI) {
				sumTempI+=sum+v[i];
				//Aqui anoto índice izq temporal
			}
			sum+=v[i];
		}
		//Repetir por la derecha con sumaTempD
		return -1; //return Max3(sumI,sumD,sumTempI+sumTempD);
	}
}
