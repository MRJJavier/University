#Librerias
library(kernlab)
library(ggplot2)
library(dplyr)

transformacionApartadoD <- function(datos){
  for (i in 1:dim(datos)[1]) {
    x <- datos[i,1]
    y <- datos[i,2]
    if(sqrt(x^2 + y^2) > 2) {
      datos[i,1] <- 4 - y + abs(x - y)
      datos[i,2] <- 4 - x + abs(x - y)
    }
  }
  return(datos)
}


calcularValoresKernel <- function(puntos){
  valoresKernel <- matrix(ncol = dim(puntos)[1], nrow=dim(puntos)[1])
  for (i in 1:dim(puntos)[1]) {
    for (j in 1:dim(puntos)[1]) {
      valoresKernel[i,j] <- puntos[i,1] * puntos[j,1] + puntos[i,2] * puntos[j,2]
    }
  }
  return(valoresKernel)
}


calcularParametros <- function(datos, puntos){
  # Creo MSV
  inputs <- matrix(cbind(datos$x1,datos$x2), ncol=2)
  msv <- ksvm(inputs, datos$y, type="C-svc", C=100, kernel ="vanilladot", scaled=F)
  msv
  
  # 1. Vectores Soporte
  vectoresSoporte <- data.frame(X1=inputs[SVindex(msv),1], X2=inputs[SVindex(msv),2])
  cat("Vectores soporte: \n")
  print(vectoresSoporte)
  
  # 2. Matriz de Kernel
  valoresKernel <- calcularValoresKernel(vectoresSoporte)
  cat("Valores kernel: \n")
  print(valoresKernel)
  
  # 4. Calculo w
  w <- colSums(coef(msv)[[1]] * inputs[SVindex(msv),])
  cat("Vector de pesos normal al Hiperplano: ", w, "\n")
  
  # 3. Calculo ancho del canal
  anchoCanal <- 2/(sum(sqrt((w)^2)))
  cat("Ancho del canal: ",anchoCanal, "\n")
  
  # 5. Calculo b 
  b <- b(msv)
  cat("Vector B: ", b, "\n")
  
  # 6. Calculo ecuaciones del hiperplano, positivo y negativo
  print (paste(c("[",w,"]' * x + [",b,"] = 0" ), collapse=" "))
  print (paste(c("[",w,"]' * x + [",b,"] = 1" ), collapse=" "))
  print (paste(c("[",w,"]' * x + [",b,"] = -1"), collapse=" "))
  
  # 7. Clasificar puntos
  for (i in 1:dim(puntos)[1]) {
    print(paste(c("Clasificacion del punto: ", puntos[i,]), collapse=" "))
    if ((t(w) %*% puntos[i,] + b) >= 0){
      print("1")
    }else if((t(w) %*% puntos[i,]  + b) < 0){
      print("-1")
    }
  }
  
  # 8. Pinto los puntos y el hiperplano.
  rangoEjeX <- c(min(inputs[,1]), max(inputs[,1]))
  rangoEjeY <- c(min(inputs[,2]), max(inputs[,2]))
  plot(rangoEjeX, rangoEjeY, type='n', xlab='x1',ylab='x2')
  title(main="Conjunto separado linealmente")
  points(inputs[SVindex(msv),1], inputs[SVindex(msv),2])
  points(inputs[-SVindex(msv),1], inputs[-SVindex(msv),2])
  abline(b/w[2],-w[1]/w[2])
  abline((b+1)/w[2],-w[1]/w[2],lty=2)
  abline((b-1)/w[2],-w[1]/w[2],lty=2)
  
}


# Apartado A
x1 <- c(0,  4)
x2 <- c(0,  4)
y  <- c(1, -1)
datos <- data.frame("x1"=x1, "x2"=x2, "y"=y) 
puntos <- c(c(5, 6), c(1, -4))
puntos <- t(matrix(puntos, ncol=length(puntos)/2, nrow=2))
calcularParametros(datos,puntos)

# Apartado B
x1 <- c(2,  0,  1)
x2 <- c(0,  0,  1)
y  <- c(1, -1, -1)
datos <- data.frame("x1"=x1, "x2"=x2, "y"=y) 
puntos <- c(c(5, 6), c(1, -4))
puntos <- t(matrix(puntos, ncol=length(puntos)/2, nrow=2))
calcularParametros(datos,puntos)

# Apartados C y D
x1 <- c(2,  2, -2, -2,  1,  1, -1, -1)
x2 <- c(2, -2, -2,  2,  1, -1, -1,  1)
y  <- c(1,  1,  1,  1, -1, -1, -1, -1)
datos <- data.frame("x1"=x1, "x2"=x2, "y"=y)
datos <- transformacionApartadoD(datos)
puntos <- c(c(5, 6), c(1, -4), c(0, 2))
puntos <- t(matrix(puntos, ncol=length(puntos)/2, nrow=2))
calcularParametros(datos,puntos)

# Apartado E
x1 <- c(3,  3,  6,  6,  1,  0,  0, -1)
x2 <- c(1, -1,  1, -1,  0,  1, -1,  0)
y  <- c(1,  1,  1,  1, -1, -1, -1, -1)
datos <- data.frame("x1"=x1, "x2"=x2, "y"=y)
puntos <- c(c(4, 5))
puntos <- t(matrix(puntos, ncol=length(puntos)/2, nrow=2))
calcularParametros(datos,puntos)



