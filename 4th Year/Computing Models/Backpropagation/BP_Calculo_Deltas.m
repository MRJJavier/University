function  [Deltas_PC] = BP_Calculo_Deltas(S_PC,Deltas_PC,DiferT_PC,Network_PC,Parameter)
%BP_Calculo_Deltas(S_PC,Deltas_PC,DiferT_PC(:,i),Network_PC,Parameter);
    
    Deltas_PC{end} = derivar(S_PC{end}) * DiferT_PC;
    
    for i=Parameter.NumLayer-1:1
        Deltas_PC{i} = derivar(S_PC{i+1}) * (Deltas_PC{i+1} * Network_PC{i+1}'); 
    end
end