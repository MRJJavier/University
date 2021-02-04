function Vecindad = FuncionVecindad(IndGan,W,Indices)

    distancia = Distancia(Indices,IndGan,"Euclidea");
    Vecindad = exp(-distancia*2);
    
end