package Estructuras;

public class Tupla<T,K> {
	private T x;
	private K y;
	
	public Tupla(T x, K y) {
		this.x=x;
		this.y=y;
	}
	
	public T getX() {
		return this.x;
	}
	
	public K getY() {
		return this.y;
	}
	
	@Override
	public String toString() {
		return "("+this.getX()+","+this.getY()+")";
	}
}

