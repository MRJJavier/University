package backtrackingYRyP;

public class todosPrimos {

	static void todosPrimos(int N, int S, int P) {
		for(int i=P; i<=S;i++) {
			if(valid(i)) {
				prime.add(i);
				if(prime.size()<N) todosPrimos(N,S,i+1);
				else {
					if(sum(prime)==S) display();
					prime.remove(prime.size()-1);
				}
			}
		}
	}
	
	public main() {
		todosPrimos(N,S,P+1);
	}
}
