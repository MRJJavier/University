package xElevadoan;

public class Fuerzabruta {
	public Fuerzabruta() {
		
	}
	public int fuerzaBruta(int x,int n) {
		int res;
		if(n==0)res=1;
		else{
			res=x;
			for(int i=1;i<n;i++)
				res*=x;
		}
		return res;
	}
}
