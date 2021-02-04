function Ganadoras = CalculoGanadorasData(W,Data)
Ganadoras = zeros(size(Data,1),2);
for i=1:size(Data,1)
    Gx = 0;
    Gy = 0;
    HsMax = intmin;
    
    %FilaNeurona,ColumnaNeurona,FilaMalla
    for fMalla=1:size(W,3) %Filas de la malla
        for columna=1:size(W,2) %Columnas
            theta = 0.5 * sum(W(:,columna,fMalla).^2,1);
            Hs = Data(i,:) * W(:,columna,fMalla) - theta;
            if Hs > HsMax
                HsMax = Hs;
                %Gx = W(1,columna,fMalla);
                %Gy = W(2,columna,fMalla);
                Gx=columna;
                Gy=fMalla;
            end
        end
    end
    Ganadoras(i,:) = [Gx,Gy];
end
end