/**----------------------------------------------
 * -- Estructuras de Datos.  2018/19
 * -- 2º Curso del Grado en Ingeniería [Informática | del Software | de Computadores].
 * -- Escuela Técnica Superior de Ingeniería en Informática. UMA
 * --
 * -- Examen 4 de febrero de 2019
 * --
 * -- ALUMNO/NAME:
 * -- GRADO/STUDIES:
 * -- NÚM. MÁQUINA/MACHINE NUMBER:
 * --
 * ----------------------------------------------
 */

import dataStructures.graph.WeightedGraph;
import dataStructures.graph.WeightedGraph.WeightedEdge;

import dataStructures.dictionary.Dictionary;
import dataStructures.dictionary.HashDictionary;
import dataStructures.priorityQueue.PriorityQueue;
import dataStructures.priorityQueue.LinkedPriorityQueue;
import dataStructures.set.Set;
import dataStructures.set.HashSet;

public class Kruskal {
	public static <V,W> Set<WeightedEdge<V,W>> kruskal(WeightedGraph<V,W> g) {
		// COMPLETAR
		
		//Inicialización
		Dictionary<V, V> dict = new HashDictionary<>();
		PriorityQueue<WeightedEdge<V,W>> pq = new LinkedPriorityQueue<>();
		Set<WeightedEdge<V,W>> t = new HashSet<>();
		
		for(V v : g.vertices()) {
			dict.insert(v, v);
		}
		
		
		for(WeightedEdge<V,W> we : g.edges()) {
			pq.enqueue(we);
		}
		
		//Inicio del algoritmo
		while(!pq.isEmpty()) {
			WeightedEdge<V,W> we = pq.first();
			pq.dequeue();
			V repsrc = representante(we.source(),dict);
			V repdst = representante(we.destination(),dict);
			if(!repsrc.equals(repdst)) {
				dict.insert(repdst,we.source());
				t.insert(we);
			}
		}

		return t;
	}
	
	private static <V> V representante(V vertice, Dictionary<V, V> diccionario) {
		V aux=vertice;
		while(!aux.equals(diccionario.valueOf(aux))) {
			aux = diccionario.valueOf(aux);
		}
		
		return aux;
	}

	// Sólo para evaluación continua / only for part time students
	public static <V,W> Set<Set<WeightedEdge<V,W>>> kruskals(WeightedGraph<V,W> g) {

		// COMPLETAR
		
		return null;
	}
}
