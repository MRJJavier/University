function  [E] = FuncionEnergia(Data,W)
Targets = Data(1:end,end);
Outputs = (W(1:end-1,:)' * Data(1:end,1:end-1)' - W(end)')';
E = (1/2) * sum((Targets - Outputs).^2)
end % 1x2 * 2x4 = 1x4 que son las salidas