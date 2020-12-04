package relaciondyv;

public class ejercicio7 {
//a
	public static int pico(int[] a) {
		int i = 0;
		while(a[i]<a[i+1]) i++;
		return a[i];
	}
	
//b
	public static int picoDyV(int[] a,int inf,int sup) {
		int media=(inf+sup)/2;
		
		if(a[media]>a[media-1] && a[media]>a[media+1]) return a[media];
		else if(a[media] > a[media-1]) return picoDyV(a,media+1,sup);
		else return picoDyV(a,inf,media-1);
		
	}
	public static void main(String[] args) {
		int[] a= {1,2,3,4,5,6,7,8,9,10,6,5,2,1};
		System.out.println("Pico por fb: "+pico(a));
		System.out.println("Pico por dyv: "+picoDyV(a,0,a.length));
	}
}
