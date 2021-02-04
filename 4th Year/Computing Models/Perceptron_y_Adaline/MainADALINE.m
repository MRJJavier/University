clear;
clc;
close all;

load DatosLS10.mat
LR=0.1;
Limites=[-1.5, 2.5, -1.5, 2.5];
MaxEpoc=100;

W=PerceptronWeigthsGenerator(Data);
Epoc=1;
Energias = [];
while ~CheckPattern(Data,W) && Epoc<MaxEpoc
    Energia = FuncionEnergia(Data,W);
    Energias = [Energias, Energia];

     for i=1:size(Data,1)
        [Input,Output,Target]=ValoresIOTADALINE(Data,W,i);
        
        GrapDatos(Data,Limites);
        GrapPatron(Input,Output,Limites)
        GrapNeuron(W,Limites);hold off;
        drawnow
%         pause;

    
        if Output~=Target
           W=UpdateNetADALINE(W,LR,Output,Target,Input);
        end
        
        GrapDatos(Data,Limites);
        GrapPatron(Input,Output,Limites)
        GrapNeuron(W,Limites);hold off;
        drawnow
%         pause;
     
     end
    Epoc=Epoc+1;
end

plot(Energias);
disp('Matriz W');
disp(W);
disp('Energías');
disp(Energias);


