import java.io.PrintStream;

public class Generador {

	public static final int ADD = 1 ;
	public static final int SUB = 2 ;
	public static final int MUL = 3 ;
	public static final int DIV = 4 ;
	public static final int IFEQ = 5 ;
	public static final int IFLT = 6 ;
	public static final int GOTO = 7 ;
	public static final int LABEL = 8;
	public static final int ASIG = 9 ;
	public static final int PRINT = 10 ;
	public static final int HALT = 11 ;

	public static PrintStream out = System.out;
	
	protected static int indiceTemporales = 0;
	protected static int indiceEtiquetas = 0;
	
	/**
	 * Genera una instruccion de tres direccion
	 * @param command
	 */
	public static void gc(int command, String result, String arg1, String arg2) {
		switch(command){
            case ADD:
                out.println(result+" = "+arg1+" + "+arg2+" ;");
                break;
            case SUB:
                out.println(result+" = "+arg1+" - "+arg2+" ;");
                break;
            case MUL:
                out.println(result+" = "+arg1+" * "+arg2+" ;");
                break;
            case DIV:
                out.println(result+" = "+arg1+" / "+arg2+" ;");
                break;
            case IFEQ:
                out.println("if ("+arg1+" == "+arg2+") goto "+result+" ;");
                break;
            case IFLT:
                out.println("if ("+arg1+" < "+arg2+") goto "+result+" ;");
                break;
            case GOTO:
                out.println("goto "+result+" ;");
                break;
            case LABEL:
                out.println("label "+result+";");
                break;
            case ASIG:
                out.println(result+ " = "+arg1+" ;");
                break;
            case PRINT:
                out.println("print "+result+" ;");
                break;
            case HALT:
                out.println("halt ;");
                break;
            default:
                out.println("Error... Instruccion no encontrada");
        }
	}

	public static void gc(int command, String result, String arg1) {
		gc(command,result,arg1,null);
	}
		
	public static void gc(int command, String result) {
		gc(command,result,null,null);
	}
		

	/**
	 * 
	 * @return Devuelve un nombre de etiqueta distinto cada vez
	 */
	public static String nuevaTemp() {
		return "t"+indiceTemporales++;
	}
	
	/**
	 * 
	 * @return Devuelve un nombre de etiqueta distinto cada vez
	 */
	public static String nuevaEtiqueta() {
		return "L"+indiceEtiquetas++;
	}
	
	/**
	 * Genera un mensaje de error 
	 * @param mensaje
	 */
	public static void error(String mensaje) {
		System.err.println("ERROR: "+ mensaje);
		System.exit(1);
	}

}
