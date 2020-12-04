package dyvFin19;

public class Pair<T1, T2> {
	private int k;
	private int v;
	
	public Pair(int k, int v) {
		this.k=k;
		this.v=v;
	}
	
	public String toString() {
		return "("+this.k+","+this.v+")";
	}
}
