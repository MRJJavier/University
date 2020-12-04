import java.io.FileReader;
import java.io.IOException;

public class Main {
    protected static int caracter = 0;
    protected static int palabra = 0;
    protected static int linea = 0;
    
    public static void add(int x,int y) {
    	x+=y;
    }
    
    public static int getSuma() {
    	return suma;
    }
    
    public static void reset() {
        suma = 0;	
    }
    
    
    public static void main(String arg[]) {
    
        if (arg.length>0) {
            try {
                Yylex lex = new Yylex(new FileReader(arg[0]));
                Yytoken yytoken = null;
		while (  (yytoken = lex.yylex()) != null  ) {
                    System.out.println(yytoken);
                    if (yytoken.getToken() == Yytoken.PALABRA)  {
                       Main.add(palabra,1);
                       Main.add(caracter,yytoken.getValor());
                    } else if (yytoken.getToken() == Yytoken.LINEA) {
                       Main.add(linea,1);
                }
                System.out.println(caracter+" "+palabra+" "+linea);
	    } catch (IOException e) {
	    }
        }
    }

}
