function W=IncrementarPesos(W,Patron,Vecindad,eta)

W = W + eta .* Vecindad .* (Patron - W);

end