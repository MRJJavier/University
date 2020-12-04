package ejercicio3;
import dataStructures.stack.*;
public class PostFix{
	
	
	public static void main(String [] args) {
		Item [] sample = {
				new Data(5),
				new Data(6),
				new Data(2),
				new Dif(),
				new Data(3),
				new Mul(),
				new Add() };
		System.out.println(evaluate(sample));
	}
	
	static int evaluate(Item[] exprList) {
		Stack<Integer> stck = new ArrayStack<>();
		for(int i=0;i<exprList.length;i++) {
			if(exprList[i].isData()) stck.push(exprList[i].getValue());
			if(exprList[i].isOperation()) {
				int arg2 = stck.top();
				stck.pop();
				int arg1 = stck.top();
				stck.pop();
				stck.push(exprList[i].evaluate(arg1, arg2));
			}
		}
		return stck.top();
	}
}
