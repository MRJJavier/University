package dyvFin19;

import java.util.HashSet;
import java.util.Set;


public class dyvFin19 {
	public static <K,V> Set<Pair<K,V>> generatePairs(int[] v,int init1, int fin1, int init2, int fin2){
		Set<Pair<K,V>> s = null;
		return s;
	}
	public static <K,V> Set<Pair<K,V>> generteAllPairs(int[] v){
		return generatePairsRec(v,0,v.length-1);
	}
	public static <K,V> Set<Pair<K,V>> generatePairsRec(int[] v, int izq, int der) {
		Set<Pair<K,V>> s = new HashSet();
		int med = (izq+der)/2;
		if(izq<der) {
			s.addAll(generatePairs(v,izq,med,med+1,der));
			s.addAll(generatePairsRec(v,izq,med));
			s.addAll(generatePairsRec(v,med+1,der));
		}
		return s;
	}
}
