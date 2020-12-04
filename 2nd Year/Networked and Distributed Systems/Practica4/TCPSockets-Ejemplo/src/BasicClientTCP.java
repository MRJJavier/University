import java.io.*;
import java.net.*;
import java.util.Scanner;
public class BasicClientTCP 
{
    public static void main(String[] args) throws IOException 
    {
        try 
        {
        	Socket echoSocket = new Socket("192.168.164.11",12345);

        	PrintWriter out = new PrintWriter(echoSocket.getOutputStream(),true);
        	BufferedReader in = new BufferedReader(new InputStreamReader(echoSocket.getInputStream()));

        	out.println("Soy el cliente y esto es un envio");
        	Scanner scanner = new Scanner(System.in);
        	scanner.useDelimiter("\r\n");
        	String clave = scanner.next();
        	while(clave!="0") {
        		out.print(clave+"\r\n");
        		String envio = scanner.next();
        		out.println(envio);
        		System.out.println("Mensaje recibido del servidor: " + in.readLine());
        		clave=scanner.next();
        	}
        	out.println(clave);
        	scanner.close();
  
            System.out.println("Mensaje recibido del servidor: " + in.readLine());
            out.close();
            in.close();      
            
            echoSocket.close();

        } 
        catch (Exception e) 
        {
            System.err.println("Error");
            System.exit(1);
        }         
    }
}