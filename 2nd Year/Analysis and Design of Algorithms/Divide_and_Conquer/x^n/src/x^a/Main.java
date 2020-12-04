package xElevadoan;
import xElevadoan.Fuerzabruta;
import xElevadoan.Divideyvenceras;

public class Main {

	public static int recursiva (int n){
		if ( n <= 1 )
		return 1;
		else
		return recursiva (n-1)+recursiva(n-1);
		};
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Fuerzabruta fb = new Fuerzabruta();
		Divideyvenceras dyv = new Divideyvenceras();
		boolean distintos=false;
		for(int i=0;i<6;i++) {
			for(int j=0;j<10;j++) {
				int res1=fb.fuerzaBruta(i,j);
				int res2=dyv.divideyVenceras(i,j);
		//		System.out.println("Var i "+i+", var j "+j+", fb "+res1+", dyv "+res2);
				if(res1!=res2)distintos=true;
			}
		}
		//System.out.println("Dan distintos resultados? "+distintos);
		System.out.println(recursiva(5));
	}

}
