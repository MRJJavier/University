function [check] = CheckPattern(Data,W)
check = sign(W(1:end-1)'*Data(:,1:end-1)'-W(end)) == Data(:,end)';
check = sum(check) == size(Data,1);
end