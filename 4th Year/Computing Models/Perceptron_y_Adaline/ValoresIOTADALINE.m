function  [Input,Output,Target] = ValoresIOTADALINE(Data,W,i)
Input=Data(i,1:end-1);
Output=Input*W(1:end-1)-W(end);
Target=Data(i,end);
end