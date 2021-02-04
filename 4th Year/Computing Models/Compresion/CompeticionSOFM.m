function Ganadoras = CompeticionSOFM(Model,Muestras)
Ganadoras = zeros(size(Muestras,2),1);
W = Model.Medias;
theta = 0.5 * sum(Model.Medias.^2);
for i=1:size(Muestras,2) %Por cada muestra

    for fMalla=1:size(W,3) %Filas de la malla
        Hs(fMalla,:) = Muestras(:,i)' * W(:,:,fMalla) - theta(:,:,fMalla);
    end
    Ys = Hs == max(Hs,[],"all");
    [fila, columna] = find(Ys);
    Ganadoras(i) = Model.NumFilasMapa * (fila - 1) + columna;
end
end