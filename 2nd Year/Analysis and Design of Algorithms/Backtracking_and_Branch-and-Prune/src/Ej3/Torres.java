package Ej3;

import java.util.Random;

public class Torres {
	private int n;
	private int[][] tablero;
	private boolean exito;
	Random r = new Random();
	
	public Torres(int tam) {
		this.n = tam;
		this.tablero = new int[tam][tam];
		for(int i=0; i<n;i++) for(int j=0;j<n;j++) tablero[i][j]=0;
		for(int i=0;i<n;i++) tablero[r.nextInt(n)][r.nextInt(n)]=-1;
		this.exito=false;
	}
	
	public int[][] vueltaAtras(){
		VA(1,0,0);
		return tablero;
	}
	
	public void VA(int etapa,int x,int y) {
		for(int i=x;!exito && i<n;i++) {
			for(int j=y; !exito && j<n;j++) {
				boolean obstaculo=false;
				if(tablero[i][j]!=-1)tablero[i][j]=etapa;
				else obstaculo=true;
				if(!obstaculo && valido(i,j)) {
					exito=exito();
					if(j==n-1)VA(etapa+1,x+1,0);
					else VA(etapa+1,x,y+1);
					if(!exito) {
						tablero[i][j]=-2;
						for(int k=i;k<n;k++) {
							for(int z=j;z<n;z++) {
								if((k!=i && z!=j)&&tablero[k][z]!=-1)tablero[k][z]=0;
							}
						}
					}
				}else {
					if(!obstaculo)tablero[i][j]=-2;
					else obstaculo=false;
				}
			}
		}
	}
	
	private boolean exito() {
		boolean ex=true;
		for(int k=0;k<n;k++) {
			for(int z=0;z<n;z++) {
				if(tablero[k][z]==0) {
					ex=false;
					break;
				}
			}
		}
		return ex;
	}
	
	private boolean valido(int x, int y) {
		boolean val=true;
		for(int i=x;val && i<n;i++) {
			if(tablero[i][y]==-1) break;
			if(tablero[x][y]!=tablero[i][y] && tablero[i][y]>0) {
				val=false;
				break;
			}
		}
		for(int i=x;val && 0<=i;i--) {
			if(tablero[i][y]==-1) break;
			if(tablero[x][y]!=tablero[i][y] && tablero[i][y]>0) {
				val=false;
				break;
			}
		}
		for(int i=y;val && i<n;i++) {
			if(tablero[x][i]==-1) break;
			if(tablero[x][y]!=tablero[x][i] && tablero[x][i]>0) {
				val=false;
				break;
			}
		}
		for(int i=y;val && 0<=i;i--) {
			if(tablero[x][i]==-1) break;
			if(tablero[x][y]!=tablero[x][i] && tablero[x][i]>0) {
				val=false;
				break;
			}
		}
		return val;
	}
	
	public void toString(int[][] sol) {
		for(int i=0;i<sol.length;i++) {
			for(int j=0;j<sol.length;j++) {
				System.out.print(sol[i][j]+" ");
			}
			System.out.println();
		}
	}
	
	public static void main(String[] args) {
		Torres t = new Torres(4);
		int[][] sol = t.vueltaAtras();
		t.toString(sol);
	}
}
