package Ej7;

import java.util.Arrays;
import java.util.Vector;


public class Constructor {
	private int[][] tabla;
	private int[] solucion;
	private int optimo;
	private int[] s;
	
	public Constructor(int[][] t) {
		this.tabla=t;
		this.solucion = new int[tabla.length];
		this.s = new int[tabla.length];
		this.optimo=-1;
		
	}
	
	public int[] vueltaAtras() {
		VA(0);
		return solucion;
	}
	public void VA(int etapa) {
		if(etapa<tabla.length) {
			for(int i=0; i<tabla.length;i++) {
				s[etapa]=i;
				if(valido(etapa)) {
					VA(etapa+1);
				}
			}
		}else {
			int sum=0;
			for(int i=0;i<s.length;i++) {
				sum+=tabla[i][s[i]];
			}
			if(optimo==-1 || sum<optimo) {
				optimo=sum;
				solucion = s.clone();
			}
		}
		
	}
	
	private boolean valido(int etapa) {
		boolean val=true;
		for(int i=0;i<=etapa;i++) 
			for(int j=i;j<=etapa;j++) 
				if(i!=j && s[i]==s[j]) val=false;
		return val;
	}
	
	public static void main(String[] args) {
		int[][] t = {{1,2,8},{2,5,3},{1,7,9}};
		int[] sol;
		Constructor c = new Constructor(t);
		sol=c.vueltaAtras();
		for(int i=0;i<sol.length;i++) {
			System.out.println("Edificio: "+i+", en el solar:"+sol[i]+", con coste: "+c.tabla[i][sol[i]]);
		}
	}
}
