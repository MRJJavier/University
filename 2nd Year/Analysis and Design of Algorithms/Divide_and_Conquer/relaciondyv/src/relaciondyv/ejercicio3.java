package relaciondyv;

public class ejercicio3 {
	
	//asume que hay mayoritario
	public static int mayoritario(int[] a,int left,int right) {
		if(left==right) return a[right];
		int mid=(right-left)/2 + left;
		int leftM = mayoritario(a,left,mid);
		int rightM = mayoritario(a,mid+1,right);
		if(leftM==rightM) return rightM;
		int cleft=0,cright=0;
		for(int i=1;i<right;i++) {
			if(a[i]==leftM)cleft++;
			if(a[i]==rightM)cright++;
		}
		return (cleft>cright) ? leftM:rightM;
	}
	
	
	public static void main(String[] args) {
		int[] a= {1,2,3,4,4,4,3,2,1,1};
		System.out.println(mayoritario(a,0,a.length));
		
	}
	
}
