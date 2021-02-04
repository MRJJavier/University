function [iter] = CheckPocket(Data,W)
check = sign(W(1:end-1)'*Data(:,1:end-1)'-W(end)) == Data(:,end)';
iter =  sum(check);
end