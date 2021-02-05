function  [S_PC,h_PC] = BP_Output_Neurona(Network_PC,h_PC,S_PC, Pattern, Parameter)
%[S_PC,h_PC] = BP_Output_Neurona(Network_PC,h_PC,S_PC, Pattern, Parameter);
    
    h_PC{1} = Pattern * Network_PC{1}; % dim 1 x 10 = Potencial sináptico
    S_PC{1} = Sigmoide(h_PC{1}); %Salida de primera capa (S1)
    
    for i=2:Parameter.NumLayer
        h_PC{i} = S_PC{i-1} * Network_PC{i}; % w * s  
        S_PC{i} = Sigmoide(h_PC{i});
    end
end