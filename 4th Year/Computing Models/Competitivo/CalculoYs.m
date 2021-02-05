function [ys] = CalculoYs(hs)
    [maxHs, idx] = max(hs,[],2);
    ys = zeros(size(hs));
    for i=1:size(idx,1)
        ys(i,idx(i,:)) = 1;
    end
    
end