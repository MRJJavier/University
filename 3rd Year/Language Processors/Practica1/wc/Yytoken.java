public class Yytoken {
    public final static int CARACTER = 127;
    public final static int PALABRA = 128;
    public final static int LINEA = 129;

    private int token;
    private int valor;

    public Yytoken(int token, int valor) {
         this.token = token;
         this.valor = valor;
    }
    public Yytoken(int token, String lexema) {
         this(token, Integer.parseInt(lexema));
    }

    public int getToken()  {
         return token;
    }

    public int getValor() {
         return valor;
    }

    public String toString() {
         return "<"+token+","+valor+">";
    }
}
