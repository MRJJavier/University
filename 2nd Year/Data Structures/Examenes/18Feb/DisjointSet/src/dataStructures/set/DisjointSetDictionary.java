/**
 * Estructuras de Datos. Grados en Informatica. UMA.
 * Examen de febrero de 2018.
 *
 * Apellidos, Nombre:
 * Titulacion, Grupo:
 */

package dataStructures.set;

import dataStructures.dictionary.AVLDictionary;
import dataStructures.dictionary.Dictionary;
import dataStructures.list.ArrayList;
import dataStructures.list.List;
import dataStructures.tuple.Tuple2;

public class DisjointSetDictionary<T extends Comparable<? super T>> implements DisjointSet<T> {

    private Dictionary<T, T> dic;

    /**
     * Inicializa las estructuras necesarias.
     */
    public DisjointSetDictionary() {
        // TODO
    	dic=new AVLDictionary<>();
    }

    /**
     * Devuelve {@code true} si el conjunto no contiene elementos.
     */
    @Override
    public boolean isEmpty() {
        // TODO
        return dic==null;
    }

    /**
     * Devuelve {@code true} si {@code elem} es un elemento del conjunto.
     */
    @Override
    public boolean isElem(T elem) {
        // TODO
    	if(!isEmpty()) return dic.isDefinedAt(elem);
    	
        return false;
    }

    /**
     * Devuelve el numero total de elementos del conjunto.
     */

    @Override
    public int numElements() {
        // TODO
    	
        return dic.size();
    }

    /**
     * Agrega {@code elem} al conjunto. Si {@code elem} no pertenece al
     * conjunto, crea una nueva clase de equivalencia con {@code elem}. Si
     * {@code elem} pertencece al conjunto no hace nada.
     */
    @Override
    public void add(T elem) {
        // TODO
    	if(!isElem(elem)) dic.insert(elem, elem);
    }

    /**
     * Devuelve el elemento canonico (la raiz) de la clase de equivalencia la
     * que pertenece {@code elem}. Si {@code elem} no pertenece al conjunto
     * devuelve {@code null}.
     */
    private T root(T elem) {
        // TODO
    	T root=null;
    	if(isElem(elem)) {
        	while(!isRoot(elem)) 
        		elem=dic.valueOf(elem);
        	root=elem;
    	}
    	return root;
    }

    /**
     * Devuelve {@code true} si {@code elem} es el elemento canonico (la raiz)
     * de la clase de equivalencia a la que pertenece.
     */
    private boolean isRoot(T elem) {
        // TODO
        return isElem(elem) && elem==dic.valueOf(elem);
    }

    /**
     * Devuelve {@code true} si {@code elem1} y {@code elem2} estan en la misma
     * clase de equivalencia.
     */
    @Override
    public boolean areConnected(T elem1, T elem2) {
        // TODO
        return isElem(elem1) && isElem(elem2) && root(elem1)==root(elem2);
    }

    /**
     * Devuelve una lista con los elementos pertenecientes a la clase de
     * equivalencia en la que esta {@code elem}. Si {@code elem} no pertenece al
     * conjunto devuelve la lista vacia.
     */
    @Override
    public List<T> kind(T elem) {
        // TODO
    	List<T> equiv = new ArrayList<>();
    	if(isElem(elem)) {
    		T root = root(elem);
    		for(Tuple2<T, T> tupleTt : dic.keysValues()) 
    			if(tupleTt._2()==root) equiv.append(tupleTt._1());
    	}
        return equiv;
    }

    /**
     * Une las clases de equivalencias de {@code elem1} y {@code elem2}. Si
     * alguno de los dos argumentos no esta en el conjunto lanzara una excepcion
     * {@code IllegalArgumenException}.
     */
    @Override
    public void union(T elem1, T elem2) {
        // TODO
    	if(!isElem(elem1) || !isElem(elem2)) throw new IllegalArgumentException();
    	if(!areConnected(elem1,elem2)) {
    		T r1= root(elem1);
    		T r2= root(elem2);
    		T k = r1.compareTo(r2) < 0 ? r2 : r1;
    		T v = r1.compareTo(r2) < 0 ? r1 : r2;
    		dic.insert(k, v);
    		
    	}
    	
    }

    // ====================================================
    // A partir de aqui solo para alumnos a tiempo parcial
    // que no sigan el proceso de evaluacion continua.
    // ====================================================

    /**
     * Aplana la estructura de manera que todos los elementos se asocien
     * directamente con su representante canonico.
     */
    @Override
    public void flatten() {
        // TODO
    	
    	Dictionary<T,List<T>> sort = sort();
    	for(Tuple2<T, List<T>> tupleTlt : sort.keysValues()) 
    		for(T elem : tupleTlt._2()) 
    			dic.insert(elem, tupleTlt._1());
    		
    	
    	
    }

    /**
     * Devuelve una lista que contiene las clases de equivalencia del conjunto
     * como listas.
     */
    @Override
    public List<List<T>> kinds() {
        // TODO
    	List<List<T>> llist = new ArrayList<>();
    	Dictionary<T,List<T>> sort = sort();
    	for(List<T> list : sort.values()) {
    		llist.append(list);
    	}
    	
        return llist;
    }
    
    /*
     * Metodo privado del alumno
     * Devuelve un diccionario con los valores canonicos como claves y listas con los 
     * elementos pertenecientes a su clase de equivalencia en una lista como valor.
     */
    private Dictionary<T, List<T>> sort(){
    	
    	Dictionary<T,List<T>> sort = new AVLDictionary<>();
    	for(T elem : dic.keys()) {
    		T r = root(elem);
    		List<T> vl;
    		if(!sort.isDefinedAt(r)) {
    			vl = new ArrayList<>();
    			vl.append(elem);
    			sort.insert(r, vl);
    		}else {
    			vl = sort.valueOf(r);
    			vl.append(elem);
    			sort.insert(r, vl);
    		}
    	}
    	
    	return sort;
    }

    /**
     * Devuelve una representacion del conjunto como una {@code String}.
     */
    @Override
    public String toString() {
        return "DisjointSetDictionary(" + dic.toString() + ")";
    }
}
