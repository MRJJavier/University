import java.io.*;
import java.net.*;

class BasicServerTCP {

    @SuppressWarnings("resource")
	public static void main(String[] args) throws IOException
    {
        
        try
        {
        	ServerSocket server = new ServerSocket(50000,10);
        	
            while (true) //funcion del servidor:
            {
            	Socket client = server.accept();
            
            	BufferedReader in = new BufferedReader(new InputStreamReader(client.getInputStream()));
            	PrintWriter out = new PrintWriter(client.getOutputStream(), true);
            	
            	out.println("Bienvenido al servicio de cifrado");
            	
                String clave =in.readLine();
                String text = in.readLine();
            	System.out.println("Mensaje del cliente: " + text);
            	String res;
            	if(clave!="0") res= encriptar(text, Integer.parseInt(clave));
            	else res="OK";
                out.println("Respuesta del servidor"+res);
                
                in.close();
                out.close();
                client.close();
            }
        }
        catch (Exception e)
        {
            System.out.println("Error");
            System.exit(-1);
        }
    }
    
    private static String encriptar(String texto, int clave) {
    	int numLetras = 'Z'-'A'+ 1;
        clave = clave % numLetras;
    	String res = "";
    	for(int i=0;i<texto.length();i++) {
    		char c = texto.charAt(i);
    		if(('A'<=c && c<='Z')||('a'<=c && 'z'<=c)) {
    			if((('a'<=c && 'z'<=c) && c + clave > 'Z')||(('A'<=c && c<='Z') && c+ clave > 'z')){
    				c = (char) (c - numLetras);
    			}
    			c = (char) (c+clave);
    		}
    		res += c;
    	}
    	return res;
    }
}