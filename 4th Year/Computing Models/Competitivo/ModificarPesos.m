function [w] = ModificarPesos(w,ys,patron,lr)
    [a, idx] = max(ys);
    w(:,idx) = w(:,idx) + lr * (patron' - w(:,idx));
end