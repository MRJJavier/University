package relaciondyv;

public class ejercicio1 {

	public int busqueda(int[] v,int inf,int sup) {
		if(inf>sup) return -1;
		int medio = (inf+sup)/2;
		if(medio==v[medio]) return medio;
		else if(medio < v[medio]) return busqueda(v,inf,medio-1);
		else return busqueda(v,medio+1,sup);
	}
}
