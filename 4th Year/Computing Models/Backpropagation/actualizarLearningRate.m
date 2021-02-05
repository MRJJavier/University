function [learningRate] = actualizarLearningRate(epocaAct, maxEpoc, learningRateBase) %El learning rate se adapta para ir de 0.5 a 0.001 según el número de épocas mediante interpolación
%Parameter.Eta = actualizarLearningRate(NumEpoc, Parameter.NumEpoch, learningRateBase);
    learningRate = learningRateBase + (epocaAct - 1) / (maxEpoc - 1) * (0.001 - learningRateBase);
end