package relaciondyv;

public class ejercicio8 {

	public static int maxInc(int[]a,int left,int right) {
		if(left==right)return 1;
		int mid=(right-left)/2 + left;
		int leftCount =maxInc(a,left,mid);
		int rightCount = maxInc(a,mid+1,right);
		int crossCount=1;
		int i = mid;
		while(i>left && a[i]>a[i-1]) {
			crossCount++;
			i--;
		}
		i = mid;
		while(i<right && a[i]<a[i+1]) {
			crossCount++;
			i++;
		}
		return Math.max(leftCount, Math.max(rightCount, crossCount));
		
	}
}
