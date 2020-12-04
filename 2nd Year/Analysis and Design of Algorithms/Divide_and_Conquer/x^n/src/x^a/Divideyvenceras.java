package xElevadoan;

public class Divideyvenceras {
	public Divideyvenceras() {
		
	}
	public int divideyVenceras(int x, int n) {
		int res;
		if(n==0) res=1;
		else if(n==1) res=x;
		else {
			int dyv;
			if(n%2==0) {
				dyv=divideyVenceras(x,n/2);
				res=dyv*dyv;
			}else {
				dyv=divideyVenceras(x,(n-1)/2);
				res=x*dyv*dyv;
			}
		}
		return res;
	}
}
