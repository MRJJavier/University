function  [Input,Output,Target] = ValoresIOT(Data,W,i)
Input=Data(i,1:end-1);
Output=sign(Input*W(1:end-1)-W(end));
Target=Data(i,end);
end