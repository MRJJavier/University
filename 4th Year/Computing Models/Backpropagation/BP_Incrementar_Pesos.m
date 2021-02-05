function [Network_PC] = BP_Incrementar_Pesos(Network_PC,Deltas_PC,S_PC,Pattern,Parameter)
%Network_PC=BP_Incrementar_Pesos(Network_PC,Deltas_PC,S_PC,Pattern,Parameter);
    Network_PC{1} = Network_PC{1} + Parameter.Eta .* (Pattern' * Deltas_PC{1}) ; 
        
    for i=2:Parameter.NumLayer
        Network_PC{i} = Network_PC{i} + Parameter.Eta .* (S_PC{i-1}' * Deltas_PC{i}); 
    end
    

end