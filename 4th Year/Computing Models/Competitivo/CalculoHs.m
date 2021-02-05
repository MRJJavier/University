function [hs] = CalculoHs(w, patron)
    theta = 0.5 * sum(w.^2,1);
    hs = patron * w - theta;
end