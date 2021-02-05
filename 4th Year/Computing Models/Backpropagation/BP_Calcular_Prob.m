function  [MSE] = BP_Calcular_Prob(Network_PCFinal, Datos,Parameter, Reg_Cla)
%MSE.PC.Prob=BP_Calcular_Prob(Network_PCFinal, Datos.Tests,Parameter);
    [NumPatTest,~] = size(Datos);
    Accuracy_PC = zeros(Parameter.NumNeu(end),NumPatTest);
    h_PC=cell(1,Parameter.NumLayer);
    S_PC=cell(1,Parameter.NumLayer);
    for N=1:Parameter.NumLayer
        h_PC{N}=zeros(1,Parameter.NumNeu(N+1)); 
        S_PC{N}=zeros(1,Parameter.NumNeu(N+1));
    end
    
    p = 1:NumPatTest;
    
    for i=1:NumPatTest
        Pattern=Datos(p(i),1:Parameter.NumNeu(1));
        Target=Datos(p(i),Parameter.NumNeu(1)+1:end);
        [S_PC,h_PC] = BP_Output_Neurona(Network_PCFinal,h_PC,S_PC, Pattern, Parameter);
        if Reg_Cla == "Regresion/"
            Accuracy_PC(:,i)=(Target - S_PC{end});
        end
        if Reg_Cla == "Clasificacion/"
            Accuracy_PC(:,i)=(Target == round(S_PC{end}));
        end
    end
    
    if Reg_Cla == "Regresion/"
        MSE = sum(Accuracy_PC.^2)/NumPatTest;
    end
    
    if Reg_Cla == "Clasificacion/"
        MSE = sum(Accuracy_PC)/NumPatTest * 100;
    end
    
end




















