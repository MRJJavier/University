imagenesRGB =["Baboon.png","Lena.png","Peppers.png"];
Comprimidas =["BaboonSOFM.tif","LenaSOFM.tif","PeppersSOFM.tif"];
RMSTotal = zeros(size(imagenesRGB));

for i=1:length(imagenesRGB)
    imagenRGB=imread(imagenesRGB(i));
    Comprimida=imread(Comprimidas(i));
    error=imagenRGB-Comprimida;
    RMS(1)=(sum(sum(double(error(:,:,1)).*double(error(:,:,1))))/262144);
    RMS(2)=(sum(sum(double(error(:,:,2)).*double(error(:,:,2))))/262144);
    RMS(3)=(sum(sum(double(error(:,:,3)).*double(error(:,:,3))))/262144);
    RMSTotal(i)=sqrt(sum(RMS)/3);
    
end

imagenesRGB
RMSTotal

