package ejercicio2; 
import dataStructures.stack.*;
public class WellBalanced {
	private final static String OPEN_PARENTHESES="{[(";
	private final static String CLOSED_PARENTHESES="}])";
	
	public static void main(String [] args) {
		Stack<Character> stck = new ArrayStack<>();
		String str = "vv(hg(jij)hags{ss[dd]dd})";
		System.out.println(wellBalanced(str,stck));
		
	}
	
	public static boolean wellBalanced(String exp, Stack<Character> stack) {
		for(char c : exp.toCharArray()) {
			if(isOpenParentheses(c)) stack.push(c);
			if(isClosedParentheses(c)) {
				if(match(stack.top(),c)) stack.pop();
			}
		}
		return stack.isEmpty();
	}
	public static boolean isOpenParentheses(char c) {
		
		return OPEN_PARENTHESES.indexOf(new Character(c).toString()) >= 0;
	}
	
	public static boolean isClosedParentheses(char c) {
		return CLOSED_PARENTHESES.indexOf(new Character(c).toString()) >= 0;
	}
		
	public static boolean match(char x, char y) {
		return OPEN_PARENTHESES.indexOf(new Character(x).toString()) ==
		CLOSED_PARENTHESES.indexOf(new Character(y).toString());
	}
		
}
