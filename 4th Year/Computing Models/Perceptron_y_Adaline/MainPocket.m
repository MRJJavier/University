clear;
clc;
close all;

load DatosAND.mat
LR = 0.2;
Limites = [-1.5, 2.5, -1.5, 2.5];
MaxEpoc = 50;

W = PerceptronWeigthsGenerator(Data);
Epoc = 1;
% Percetrón con bolsillo
Wpocket = W;
Iter = CheckPocket(Data, W);
maxIter = Iter;

while ~CheckPattern(Data,W) && Epoc<MaxEpoc
     for i=1:size(Data,1)
        [Input,Output,Target]=ValoresIOT(Data,W,i);
        
%        GrapDatos(Data,Limites);
 %       GrapPatron(Input,Output,Limites);
  %      GrapNeuron(W,Limites);hold off;
   %     drawnow
%       pause;
        if Output~=Target
           W=UpdateNet(W,LR,Output,Target,Input);
           
           Iter = CheckPocket(Data, W);
           if Iter > maxIter
                maxIter = Iter;
                Wpocket = W;
           end
        end
        

        
    %    GrapDatos(Data,Limites);
     %   GrapPatron(Input,Output,Limites)
      %  GrapNeuron(W,Limites);hold off;
       % drawnow
%         pause;

    end
    Epoc=Epoc+1;
end

disp('Matriz W');
disp(W);
disp('Máximas iteraciones bien');
disp(maxIter);
disp('Matriz Wpocket');
disp(Wpocket);

%epoca > iteracion

