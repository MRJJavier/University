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
import dataStructures.list.ArrayList;
import dataStructures.list.List;
import dataStructures.set.HashSet;
import dataStructures.set.Set;
import dataStructures.tuple.Tuple2;

public class TopologicalSortingDic<V> {

    private List<V> topSort;
    private boolean hasCycle;

    public TopologicalSortingDic(DiGraph<V> graph) {

        topSort = new ArrayList<>();
        // dictionary: vertex -> # of pending predecessors
        Dictionary<V, Integer> pendingPredecessors = new HashDictionary<>();
        // completar
        hasCycle=true;
        for(V vertice : graph.vertices()) {
        	int ant = graph.inDegree(vertice);
        	if(ant==0 && hasCycle) hasCycle = false; 
        	pendingPredecessors.insert(vertice, ant);
        }
        
        while(!pendingPredecessors.isEmpty() && !hasCycle) {
        	hasCycle=true;
        	Set<V> fuentes = new HashSet<>();
        	
        	for(Tuple2<V, Integer> tupleVi : pendingPredecessors.keysValues()) 
        		if(tupleVi._2()==0) fuentes.insert(tupleVi._1());
        	
        	for(V fuente : fuentes) {
        		pendingPredecessors.delete(fuente);
    			topSort.append(fuente);
    			
    			for(V act : graph.successors(fuente)) {
    				int nant = pendingPredecessors.valueOf(act) -1;
    				pendingPredecessors.insert(act,nant);
        			if(nant==0 && hasCycle) hasCycle=false;
    			}
    			
        	}
        	
        	if(pendingPredecessors.isEmpty()) hasCycle=false;
        }
        
    }

    public boolean hasCycle() {
        return hasCycle;
    }

    public List<V> order() {
        return hasCycle ? null : topSort;
    }
}
