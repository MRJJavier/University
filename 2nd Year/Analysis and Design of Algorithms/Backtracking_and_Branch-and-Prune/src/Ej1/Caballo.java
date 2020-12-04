package Ej1;
import Estructuras.Tupla;

public class Caballo {
	private int n;
	private int[][] tablero;
	private boolean exito;
	private int[] movX = {2,2,-2,-2,1,1,-1,-1};
	private int[] movY = {1,-1,1,-1,2,-2,2,-2};
	private Tupla<Integer,Integer>[] solucion;
	
	
	public Caballo(int tam) {
		this.n=tam;
		this.tablero = new int[n][n];
		for(int i=0;i<n;i++)for(int j=0;j<n;j++)tablero[i][j]=0;
		this.solucion = new Tupla[n*n];
		this.exito=false;
	}
	
	public Tupla<Integer,Integer>[] vueltaAtras(int x, int y) {
		solucion[0] = new Tupla<Integer, Integer>(x,y);
		tablero[x][y]=1;
		VA(1,x,y);
		return solucion;
	}
	
	
	private void VA(int k,int x,int y) {
		int newX,newY;
		for(int orden=0;(!exito)&&(orden<movX.length);orden++) {
			newX = x + movX[orden];
			newY = y + movY[orden];
			if((0<=newX)&&(newX<n)&&(0<=newY)&&(newY<n)&&tablero[newX][newY]==0) {
				tablero[newX][newY]=k+1;
				solucion[k]= new Tupla<Integer, Integer>(newX,newY);
				if(k<solucion.length-1) {
					VA(k+1,newX,newY);
					if(!exito) tablero[newX][newY]=0;
				}else {
					exito=true;
				}
			}
		}
	}
	
	public static void main(String[] args) {
		int n=6;
		Caballo c = new Caballo(n);
		Tupla<Integer,Integer>[] t = c.vueltaAtras(n-1,0);
		if(c.exito) {
			for(int i=0;i<n;i++) {
				for(int j=0;j<n;j++) {
					if(j==n-1) System.out.println(c.tablero[i][j]);
					else System.out.print(c.tablero[i][j]+" ");
				}
			}
			for(int i=0;i<t.length;i++) 
				System.out.println("Movimiento: "+i+", posicion: "+t[i].toString());
		}else System.out.println("No existe solucion.");
	}
}


