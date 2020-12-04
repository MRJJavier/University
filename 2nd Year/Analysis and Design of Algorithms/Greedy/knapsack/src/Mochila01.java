import java.util.*;
final class Item implements Comparable<Item>{
	int index;
	float peso;
	float valor;
	float unidades;
	float densidad;
	
	public Item(int index, float peso, float valor, float unidades) {
		this.index = index;
		this.peso = peso;
		this.valor = valor;
		this.unidades = unidades;
		this.densidad = this.valor/this.peso;
	}
	
	
	@Override
	public int compareTo (Item otro){
		if (densidad==otro.densidad) return 0;
		else if (densidad<otro.densidad) return -1;
		return 1;  
	}
	
}

final class OrdenacionRapida  {
	  
	public static <T extends Comparable<? super T>> void ordenar(ArrayList<Item> items) {
	    ordRapidaRec(items, 0, items.size()-1);
	}

	// Debe ordenar ascendentemente los primeros @n elementos del vector @v con 
	// una implementaci�n recursiva del m�todo de ordenaci�n r�pida.	
	public static <T extends Comparable<? super T>> void ordRapidaRec(ArrayList<Item> items, int izq, int der) {
	    // A completar por el alumno
		if(izq < der) {
			int s=partir(items,items.get(izq),izq,der);
			ordRapidaRec(items,izq,s);
			ordRapidaRec(items,s+1,der);
		}	
	}
	
   public static <T extends Comparable<? super T>> int partir(ArrayList<Item> items, Item item, int izq, int der) {
	    // A completar por el alumno
	   int i=izq-1;
	   int j=der+1;
	   while(i<j) {
		   do {
			   j--;
		   }while(items.get(j).compareTo(item)>0);
		   do {
			   i++;
		   }while(items.get(i).compareTo(item)<0);
		   if(i<j) {
			   Item aux=items.get(i);
			   items.set(i,items.get(j));
			   items.set(j,aux);
			   
		   }
	   }
	    return j;    	
   }
  
}



public class Mochila01 {
	private ArrayList<Item> items;
	private int pesoMaximo;
	
	public Mochila01() {
		this.items=null;
		this.pesoMaximo=Integer.MIN_VALUE;
	}
	
	public Mochila01(ArrayList<Item> items, int pesoMaximo) {
		this.items=items;
		this.pesoMaximo=pesoMaximo;
	}
	
	private void inicializarMochila() {
		Scanner sc = new Scanner(System.in);
		try {
			System.out.println("Introduzca el peso máximo de la mochila: ");
			pesoMaximo=sc.nextInt();
			System.out.println("Introduzca el número de elementos: ");
			int nelem = sc.nextInt();
			if(nelem > 0) {
				items = new ArrayList<Item>(nelem);
				for(int i=0;i<nelem;i++) {
					System.out.println("Introduzca el peso del elemento "+(i+1)+":");
					int peso=sc.nextInt();
					System.out.println("Introduzca el valor del elemento "+(i+1)+":");
					int valor=sc.nextInt();
					System.out.println("Introduzca el número de unidades del elemento "+(i+1)+":");
					int unidades=sc.nextInt();
					Item item = new Item(i,peso,valor,unidades);
					items.add(item);
				}
			}else {
				items = new ArrayList<Item>(0);
			}
		}catch(Exception e) {
			System.err.println(e);
		}
		sc.close();
	}
	private ArrayList<Item> deepSortedClone(){
		ArrayList<Item> ali = new ArrayList<>();
		for(Item i : items) {
			ali.add(i);
		}
		OrdenacionRapida.ordenar(ali);
		return ali;
	}
	
	public void mochilaDiscreta() {
		if(items==null && pesoMaximo==Integer.MIN_VALUE) inicializarMochila();
		List<Item> l = new ArrayList<>();
		ArrayList<Item> citems = deepSortedClone();
		if(pesoMaximo > 0) {
			int peso=0;
			while(peso < pesoMaximo) {
				if(citems.size() == 0) break;
				Item i = citems.get(citems.size()-1);
				if(peso+i.peso <= pesoMaximo) {
					peso+=i.peso;
					boolean esta=false;
					boolean uds=false;
					for(Item it : l) {
						if(it.index == i.index) {
							it.unidades++;
							esta=true;
							if(it.unidades==i.unidades) uds=true;
						}
					}
					if(!esta)l.add(new Item(i.index,i.peso,i.valor,1));
					if(uds || i.unidades==1) citems.remove(citems.size()-1);
				}else {
					citems.remove(citems.size()-1);
				}
			}
		}
		imprimirResultados(l,true);
	}
	
	public void mochilaContinua() {
		if(items==null && pesoMaximo==Integer.MIN_VALUE) inicializarMochila();
		List<Item> l = new ArrayList<>();
		ArrayList<Item> citems = deepSortedClone();
		if(pesoMaximo > 0) {
			int peso=0;
			while(peso < pesoMaximo) {
				if(citems.size() == 0) break;
				Item i = citems.get(citems.size()-1);
				if(peso+i.peso <= pesoMaximo) {
					peso+=i.peso;
					boolean esta=false;
					boolean uds=false;
					for(Item it : l) {
						if(it.index == i.index) {
							it.unidades++;
							esta=true;
							if(it.unidades==i.unidades) uds=true;
							break;
						}
					}
					if(!esta)l.add(new Item(i.index,i.peso,i.valor,1));
					if(uds || i.unidades==1) citems.remove(citems.size()-1);
				}else {
					boolean esta=false;
					for(Item it : l) {
						if(it.index == i.index) {
							esta=true;
							it.unidades+= (pesoMaximo-peso)/i.peso;
							break;
						}
					}
					if(!esta) l.add(new Item(i.index,i.peso,i.valor,(pesoMaximo-peso)/i.peso));
					peso=pesoMaximo;
				}
			}
		}
		imprimirResultados(l,false);
	}
		
	
	
	private void imprimirResultados(List<Item> l,boolean discreta) {
		int valor=0;
		
		if(discreta) {
			System.out.println("Se han introducido en la mochila discreta los siguientes elementos: ");
			for(Item it : l) {
				valor+=it.valor*it.unidades;
				System.out.println("Elemento "+it.index+" de peso "+(int)it.peso+", valor "+(int)it.valor+" y "+(int)it.unidades+" unidad/es.");
			}
			System.out.println("Valor de la mochila discreta: "+(int)valor+"\n");
		}else {
			System.out.println("Se han introducido en la mochila continua los siguientes elementos: ");
			for(Item it : l) {
				valor+=it.valor*it.unidades;
				 System.out.println("Elemento "+it.index+" de peso "+it.peso+", valor "+it.valor+" y "+it.unidades+" unidad/es.");
			}
			System.out.println("Valor de la mochila continua: "+valor+"\n");
		}
	}
	
	public static void main(String[] args) {
		
		Mochila01 m;
		ArrayList<Item> ali = new ArrayList<>();
		
		//Si no se le dan argumentos, pide el tamaño, el nº elem y los elementos por pantalla
		System.out.println("*****\nMochila 0-1, pidiendo elementos por pantalla\n*****");
		m = new Mochila01();
		m.mochilaDiscreta();
		m.mochilaContinua();
		
		
		System.out.println("*****\nEjemplo mochila 0-1 diapositiva 19, tema greedy.\n*****");
		ali.add(new Item(1,2,12,1));
		ali.add(new Item(2,1,10,1));
		ali.add(new Item(3,3,20,1));
		ali.add(new Item(4,2,15,1));
		ali.add(new Item(5,1,5,1));
		m = new Mochila01(ali,5);
		m.mochilaDiscreta();
		m.mochilaContinua();
		
		ali.clear();
		
		System.out.println("*****\nEjemplo mochila 0-1 diapositiva 22, tema greedy.\n*****");
		ali.add(new Item(1,1,6,1));
		ali.add(new Item(2,2,10,1));
		ali.add(new Item(3,3,12,1));
		m = new Mochila01(ali,5);
		m.mochilaDiscreta();
		m.mochilaContinua();
		
		
		
		
	}
}

