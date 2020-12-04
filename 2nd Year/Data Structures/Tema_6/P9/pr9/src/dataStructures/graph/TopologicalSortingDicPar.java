/**
 * APELLIDOS : ..........................  NOMBRE: ............
 *
 * TITULACION: ..............................
 *
 * Computes Topological Sorting for DiGraphs
 */

package dataStructures.graph;

import dataStructures.dictionary.Dictionary;
import dataStructures.dictionary.HashDictionary;
import dataStructures.list.List;
import dataStructures.list.ArrayList;
import dataStructures.set.Set;
import dataStructures.tuple.Tuple2;
import dataStructures.set.HashSet;

public class TopologicalSortingDicPar<V> {

    private List<Set<V>> topSort;
    private boolean hasCycle;

    public TopologicalSortingDicPar(DiGraph<V> graph) {

        topSort = new ArrayList<>();
        // dictionary: vertex -> # of pending predecessors
        Dictionary<V, Integer> pendingPredecessors = new HashDictionary<>();
        // completar
        hasCycle=true;
        for(V vertice : graph.vertices()) {
        	int ant = graph.inDegree(vertice);
        	if(ant==0 && hasCycle) hasCycle=false;
        	pendingPredecessors.insert(vertice, ant);
        }
        while(!pendingPredecessors.isEmpty() && !hasCycle) {
        	hasCycle=true;
        	Set<V> fuentes = new HashSet<>();
        	
        	for(Tuple2<V, Integer> tupleVi : pendingPredecessors.keysValues()) {
        		if(tupleVi._2()==0) fuentes.insert(tupleVi._1());
        	}
        	
        	topSort.append(fuentes);
        	
        	for(V fuente : fuentes) {
        		pendingPredecessors.delete(fuente);
        		
        		for(V act : graph.successors(fuente)) {
        			int nant = pendingPredecessors.valueOf(act)-1;
        			pendingPredecessors.insert(act, nant);
        			if(nant==0 && hasCycle) hasCycle=false;
        		}
        		
        	}
        	if(pendingPredecessors.isEmpty()) hasCycle=false;
        }
    }

    public boolean hasCycle() {
        return hasCycle;
    }

    public List<Set<V>> order() {
        return hasCycle ? null : topSort;
    }

}
