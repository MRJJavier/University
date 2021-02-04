function Distancia=Distancia(Indices,IndGan,tipo)
    if tipo == "Euclidea"
        Distancia=sqrt(sum((Indices-IndGan).^2));
    else %Rectangular
        Distancia=sum(abs(Indices-IndGan));
    end
    
end

