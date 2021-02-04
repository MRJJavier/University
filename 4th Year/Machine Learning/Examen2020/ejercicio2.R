library(kernlab)
library(ggplot2)

#Genero los datos
datosEje2 <- read.csv("/home/mrjjavier/Descargas/ejercicio2SVM.csv")

#Represento
ggplot(datosEje2, aes(x=X1, y=X2, color=y)) + geom_point(size=2,shape=4)

#Creo la SVM
entradas <- matrix(cbind(datosEje2$X1,datosEje2$X2), ncol=2)
msv <- ksvm(entradas, datosEje2$y, type="C-svc", C=100, kernel ="polydot", kpar=list(degree=3), scaled=F)
msv

# Vectores Soporte
vectores_soporte <- data.frame(X1=entradas[SVindex(msv),1], X2=entradas[SVindex(msv),2])
vectores_soporte

# Calculo w
w <- colSums(coef(msv)[[1]] * entradas[SVindex(msv),])
cat("w: ", w, "\n")

# Calculo b 
b <- b(msv)
cat("b: ", b, "\n")

# Calculo ancho del canal
ancho_canal <- 2/(sum(sqrt((w)^2)))
cat("Ancho del canal: ",ancho_canal, "\n")

# Calculo ecuaciones del hiperplano, positivo y negativo
print (paste(c("[",w,"]' * x + [",b,"] = 0" ), collapse=" "))
print (paste(c("[",w,"]' * x + [",b,"] = 1" ), collapse=" "))
print (paste(c("[",w,"]' * x + [",b,"] = -1"), collapse=" "))

# Clasifico (0.5, 0.8)
punto_uno = c(0.5, 0.8)
if ((t(w) %*% punto_uno + b) >= 0){
  print("1")
}else if((t(w) %*% punto_uno + b) < 0){
  print("-1")
}

# Clasifico (0.6, 0.2)
punto_dos = c(0.6, 0.2)
if ((t(w) %*% punto_dos + b) >= 0){
  print("1")
}else if((t(w) %*% punto_dos + b) < 0){
  print("-1")
}

plot(msv)

