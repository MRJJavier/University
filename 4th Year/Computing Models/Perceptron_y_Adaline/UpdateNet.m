function [W] = UpdateNet(W,LR,Output,Target,Input)
Input = [Input,-1]
W = W + LR*(Target - Output)*Input'    
end


