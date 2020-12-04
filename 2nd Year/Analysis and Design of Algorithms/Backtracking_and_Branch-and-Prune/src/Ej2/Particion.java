package Ej2;

import java.util.Arrays;

public class Particion {
	private int[] U;
	private int[][] S;
	private boolean exito;
	private int[][] C;
	private int[] s;
	
	public Particion(int[] U, int[][] S) {
		this.U=U;
		this.S=S;
		this.exito=false;
	}
	
	public int[][] vueltaAtras() {
		s = new int[S.length];
		for(int i=0;i<s.length;i++)s[i]=0;
		VA(0);
		int cont=0;
		for(int i=0;i<s.length;i++) if(s[i]==1)cont++;
		C = new int[cont][1];
		cont=0;
		for(int i=0;i<s.length;i++) {
			if(s[i]==1) {
				C[cont]=S[i];
				cont++;
			}
		}
		return C;
	}
	
	private void VA(int etapa) {
		for(int i=etapa; !exito && i<S.length;i++) {
			int[] aux = new int[0];
			s[i]=1;
			boolean add=true;
			for(int j=0;j<i;j++) {
				if(s[j]==1) add=disjuntos(S[j],S[i]);
				if(!add) break;
			}
			if(add) {
				for(int j=0;j<=i;j++)if(s[j]==1)aux=union(aux,S[j]);
				if(Arrays.equals(aux, U))exito=true;
				else {
					VA(etapa+1);
					if(!exito) {
						s[i]=0;
					}
				}
			}else {
				s[i]=0;
				VA(etapa+1);
			}	
		}
	}
	
	private boolean disjuntos(int[] Si, int[] Sj) {
		int i=0;
		int j=0;
		boolean disjuntos = true;
		while(disjuntos && i<Si.length && j<Sj.length) {
			if(Si[i]==Sj[j]) disjuntos=false;
			else if(Si[i]<Sj[j]) i++;
			else j++;
		}
		return disjuntos;
	}
	
	private int[] union(int[] Si,int[] Sj) {
		int[] aux = new int[Si.length+Sj.length];
		int i=0;
		int j=0;
		int cont=0;
		while(cont<aux.length) {
			if(i<Si.length && j<Sj.length) {
				if(Si[i]<=Sj[j]) {
					aux[cont]=Si[i];
					i++;
				}else {
					aux[cont]=Sj[j];
					j++;
				}
			}else {
				if(i<Si.length) {
					aux[cont]=Si[i];
					i++;
				}else {
					aux[cont]=Sj[j];
					j++;
				}
			}
			cont++;
		}
		return aux;
	}
	
	public void toString(int[][] conjunto) {
		for(int i=0; i<conjunto.length;i++) {
			System.out.print("{");
			for(int j=0; j<conjunto[i].length;j++) {
				System.out.print(conjunto[i][j]);
				if(j!=conjunto[i].length-1) System.out.print(",");
			
			}
			System.out.println("}");
		}
	}
	
	
	public static void main(String[] args) {
		int[] U = {1,2,3,4,5,6,7,8,9,10,11,12};
		int[][] S = {{1,2,3,4,6,7,9},{4,5,7,8},{1,4},{2,5},{3,6},{6,11},{7,8,9,10,11,12}};
		Particion p = new Particion(U,S);
		int[][] solucion = p.vueltaAtras();
		p.toString(solucion);
			
		
		
		
		
	}
}
