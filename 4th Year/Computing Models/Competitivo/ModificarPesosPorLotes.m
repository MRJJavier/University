function [w] = ModificarPesosPorLotes(w,ys,patrones,lr)
    
        [a, idx] = max(ys,[],2);
        incrementos = zeros(size(w));
        for i=1:size(idx,1)
           incrementos(:,idx(i,:)) = incrementos(:,idx(i,:)) + (patrones(i,:)' - w(:,idx(i,:)));
        end
        w = w + lr.*(1./sum(ys)).*incrementos;

   
end