%José Javier Morente Risco y Rafael López Gómez

clc;
clear;
close all;
load('Datos.mat');
% rng(1)

NumNeu=4;
LRini=0.7;
IterMax=300;
% IterMax=1;
% ----Iniciar W------
[NumPat,NumInp]=size(Data);
Indices=ceil(rand(NumNeu,1)*NumPat);
% Indices=1:NumPat;
W=Data(Indices,:)';
% -----------------------

GrapEvol(Data,W,NumNeu)
drawnow

for i=1:IterMax
    i

    Patrones=Data;
    
    LR=LRini * (1-i/IterMax);
        
    Hs=CalculoHs(W,Patrones);
    Ys=CalculoYs(Hs);
    W=ModificarPesosPorLotes(W,Ys,Patrones,LR);

    %GrapEvol(Data,W,NumNeu)
    %drawnow
end

GrapFinal(Data,W,NumNeu,NumPat)
drawnow
