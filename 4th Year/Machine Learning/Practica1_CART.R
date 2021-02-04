#Librerias
library(dplyr)
library(ggplot2)

x1 <- c(2.77,1.72,3.67,3.96,2.99,7.49,9,7.44,10.12,6.64)
x2 <- c(1.78,1.16,2.81,2.61,2.20,3.16,3.33,0.47,3.23,3.31)
y <- c(0,0,0,0,0,1,1,1,1,1)
datos <- data.frame("X1" = x1, "X2" = x2, "Y" = y)

# Muestro los datos
ggplot(datos,aes(x=X1,y=X2,color=Y))+geom_point()

# Apartado A
# Algoritmo CART
CART <- function(datos){
  
  minimoX1 <- Inf
  minimoX2 <- Inf
  
  datosOrdenadosX1 <- arrange(datos, datos[1])
  datosOrdenadosX2 <- arrange(datos, datos[2])
  print("Parte X1`")
  for (i in 1:nrow(datosOrdenadosX1)){
    subconjuntoIzquierdoX1 <- datosOrdenadosX1[3][,][1:(i-1)]
    subconjuntoDerechoX1 <- datosOrdenadosX1[3][,][i:dim(datos)[1]]
    sumaRegion1X1 <- sum((subconjuntoIzquierdoX1-mean(subconjuntoIzquierdoX1))^2)
    sumaRegion2X1 <- sum((subconjuntoDerechoX1-mean(subconjuntoDerechoX1))^2)
    sumaRegionesX1 <- sumaRegion1X1 + sumaRegion2X1
    print(sumaRegionesX1)
    
    if (sumaRegionesX1 < minimoX1) {
      minimoX1 <- sumaRegionesX1
      indiceMinimoX1 <- i
    }
    
  }
  print("Parte X2")
  for (i in 1:nrow(datosOrdenadosX2)){
    subconjuntoIzquierdoX2 <- datosOrdenadosX2[3][,][0:(i-1)]
    subconjuntoDerechoX1 <- datosOrdenadosX2[3][,][i:dim(datos)[1]]
    sumaRegion1X2 <- sum((subconjuntoIzquierdoX2-mean(subconjuntoIzquierdoX2))^2)
    sumaRegion2X2 <- sum((subconjuntoDerechoX1-mean(subconjuntoDerechoX1))^2)
    sumaRegionesX2 <- sumaRegion1X2 + sumaRegion2X2
    print(sumaRegionesX2)
    
    if (sumaRegionesX2< minimoX2) {
      minimoX2 <- sumaRegionesX2
      indiceMinimoX2 <- i
    }
  }
  
  if(minimoX1 < minimoX2){
    print(paste("X1 =",datosOrdenadosX1[indiceMinimoX1,"X1"], "minimo =",minimoX1))
    resultado <- c(datosOrdenadosX1[indiceMinimoX1,"X1"],"X1")
  }else{
    print(paste("X2 =",datosOrdenadosX2[indiceMinimoX2,"X2"], "minimo =",minimoX2))
    resultado <- c(datosOrdenadosX2[indiceMinimoX2,"X2"],"X2")
  }
  
  return(resultado)
}


resultado <- CART(datos)
print("Resultado CART: ")
resultado

# Apartado B
# Ordenación del dataset según los resultados primera iteración de CART y las particiones del dataset
if(resultado[2] == "X1"){
  datosOrdenados <- arrange(datos, datos[1])
  datosParticionIzquierda <- datosOrdenados[datosOrdenados$X1 < as.numeric(resultado[1]), ]
  datosParticionDerecha <- datosOrdenados[datosOrdenados$X1 >= as.numeric(resultado[1]), ]
}else{
  datosOrdenados <- arrange(datos, datos[2])
  datosParticionIzquierda <- datosOrdenados[datosOrdenados$X2 < as.numeric(resultado[1]), ]
  datosParticionDerecha <- datosOrdenados[datosOrdenados$X2 >= as.numeric(resultado[1]), ]
}
  

# Arbol T1
# Etiqueto la región izquierda
cuentaDatosIzquierda <- datosParticionIzquierda %>% count(Y)
etiquetaRegionIzquierda <- arrange(cuentaDatosIzquierda, desc(cuentaDatosIzquierda$n))[1,1]

# Exploro la región derecha
resultadoT1 <- CART(datosParticionDerecha)
if(resultadoT1[2] == "X1"){
  datosParticionDerechaOrdenados <- arrange(datosParticionDerecha, datosParticionDerecha[1])
  
  # Etiqueto la región derecha izquierda
  datosParticionDerechaIzquierda <- datosParticionDerechaOrdenados[datosParticionDerechaOrdenados$X1 < as.numeric(resultadoT1[1]), ]
  cuentaDatosParticionDerechaIzquierda <- datosParticionDerechaIzquierda %>% count(Y)
  etiquetaRegionDerechaIzquierda <- arrange(cuentaDatosParticionDerechaIzquierda, desc(cuentaDatosParticionDerechaIzquierda$n))[1,1]
  
  # Etiqueto la región derecha derecha
  datosParticionDerechaDerecha <- datosParticionDerechaOrdenados[datosParticionDerechaOrdenados$X1 >= as.numeric(resultadoT1[1]), ]
  cuentaDatosParticionDerechaDerecha <- datosParticionDerechaDerecha %>% count(Y)
  etiquetaRegionDerechaDerecha <- arrange(cuentaDatosParticionDerechaDerecha, desc(cuentaDatosParticionDerechaDerecha$n))[1,1]
  
}else{
  datosParticionDerechaOrdenados <- arrange(datosParticionDerecha, datosParticionDerecha[2])
  
  # Etiqueto la región derecha izquierda
  datosParticionDerechaIzquierda <- datosParticionDerechaOrdenados[datosParticionDerechaOrdenados$X2 < as.numeric(resultadoT1[1]), ]
  cuentaDatosParticionDerechaIzquierda <- datosParticionDerechaIzquierda %>% count(Y)
  etiquetaRegionDerechaIzquierda <- arrange(cuentaDatosParticionDerechaIzquierda, desc(cuentaDatosParticionDerechaIzquierda$n))[1,1]
  
  # Etiqueto la región derecha derecha
  datosParticionDerechaDerecha <- datosParticionDerechaOrdenados[datosParticionDerechaOrdenados$X2 >= as.numeric(resultadoT1[1]), ]
  cuentaDatosParticionDerechaDerecha <- datosParticionDerechaDerecha %>% count(Y)
  etiquetaRegionDerechaDerecha <- arrange(cuentaDatosParticionDerechaDerecha, desc(cuentaDatosParticionDerechaDerecha$n))[1,1]
  
}

cat(
  paste("Arbol 1.\n",
        "   Nivel 0\n",
        "      Nodo 1 (o raiz): ",resultado[2]," < ",resultado[1],"\n",
        "   Nivel 1\n",
        "      Derecha\n",
        "      Nodo 2: ",resultadoT1[2]," < ",resultadoT1[1],"\n",
        "         Etiqueta Nodo Izquierdo: ",etiquetaRegionDerechaIzquierda, " - Etiqueta Nodo Derecho: ", etiquetaRegionDerechaDerecha,"\n",
        "      Izquierda\n",
        "         Etiqueta Nodo: ",etiquetaRegionIzquierda, sep = "")
)

# Arbol T2
# Etiqueto la región derecha
cuentaDatosDerecha <- datosParticionDerecha %>% count(Y)
etiquetaRegionDerecha <- arrange(cuentaDatosDerecha, desc(cuentaDatosDerecha$n))[1,1]

# Exploro la región izquierda
resultadoT2 <- CART(datosParticionIzquierda)
if(resultadoT2[2] == "X1"){
  datosParticionIzquierdaOrdenados <- arrange(datosParticionIzquierda, datosParticionIzquierda[1])
  
  # Etiqueto la región izquierda izquierda
  datosParticionIzquierdaIzquierda <- datosParticionIzquierdaOrdenados[datosParticionIzquierdaOrdenados$X1 < as.numeric(resultadoT2[1]), ]
  cuentaDatosParticionIzquierdaIzquierda <- datosParticionIzquierdaIzquierda %>% count(Y)
  etiquetaRegionIzquierdaIzquierda <- arrange(cuentaDatosParticionIzquierdaIzquierda, desc(cuentaDatosParticionIzquierdaIzquierda$n))[1,1]
  
  # Etiqueto la región izquierda derecha
  datosParticionIzquierdaDerecha <- datosParticionIzquierdaOrdenados[datosParticionIzquierdaOrdenados$X1 >= as.numeric(resultadoT2[1]), ]
  cuentaDatosParticionIzquierdaDerecha <- datosParticionIzquierdaDerecha %>% count(Y)
  etiquetaRegionIzquierdaDerecha <- arrange(cuentaDatosParticionIzquierdaDerecha, desc(cuentaDatosParticionIzquierdaDerecha$n))[1,1]
  
  
}else{
  datosParticionIzquierdaOrdenados <- arrange(datosParticionIzquierda, datosParticionIzquierda[2])

  # Etiqueto la región izquierda izquierda
  datosParticionIzquierdaIzquierda <- datosParticionIzquierdaOrdenados[datosParticionIzquierdaOrdenados$X2 < as.numeric(resultadoT2[1]), ]
  cuentaDatosParticionIzquierdaIzquierda <- datosParticionIzquierdaIzquierda %>% count(Y)
  etiquetaRegionIzquierdaIzquierda <- arrange(cuentaDatosParticionIzquierdaIzquierda, desc(cuentaDatosParticionIzquierdaIzquierda$n))[1,1]  
   
  # Etiqueto la región izquierda derecha
  datosParticionIzquierdaDerecha <- datosParticionIzquierdaOrdenados[datosParticionIzquierdaOrdenados$X2 >= as.numeric(resultadoT2[1]), ]
  cuentaDatosParticionIzquierdaDerecha <- datosParticionIzquierdaDerecha %>% count(Y)
  etiquetaRegionIzquierdaDerecha <- arrange(cuentaDatosParticionIzquierdaDerecha, desc(cuentaDatosParticionIzquierdaDerecha$n))[1,1]
  
}

cat(
  paste("Arbol 2.\n",
        "   Nivel 0\n",
        "      Nodo 1 (o raiz): ",resultado[2]," < ",resultado[1],"\n",
        "   Nivel 1\n",
        "      Derecha\n",
        "         Etiqueta Nodo: ",etiquetaRegionDerecha,"\n", 
        "      Izquierda\n",
        "      Nodo 2: ",resultadoT2[2]," < ",resultadoT2[1],"\n",
        "         Etiqueta Nodo Izquierdo: ",etiquetaRegionIzquierdaIzquierda, " - Etiqueta Nodo Derecho: ", etiquetaRegionIzquierdaDerecha,"\n",sep = "")
)

# Apartado C

# Podemos elegir entre dos criterios de parada:
# 1- Todos los elementos son del mismo tipo
# 2- El numero de elementos es inferior a X. (X podria ser el 20% del dataset por ejemplo)
#
# Indiferentemente del criterio de parada las regiones para realizar las 
# divisiones se eligirian usando el algoritmo CART que hemos implementado.
#
# Para finalizar el arbol:
# - Si elegimos el criterio 1, etiquetamos la region de ese tipo, puesto todos son del mismo
# - Si elegimos el criterio 2, etiquetamos la region con el tipo del que haya más elementos.
# 
# Ejemplo. Region con 7 elementos de un dataset de 100 (20% para criterio 2). Tipos posibles 0 y 1
# Criterio 1. Si los 7 son de tipo 0 o 1, acaba y se etiqueta con 0 o 1, si no continua
# Criterio 2. Como 7 es inferior al 20% de 100, acaba seguro. Con que más del 50% de 7 sea 0 o 1, 
# se etiqueta 0 o 1. Si el número fuera par y hubiese el mismo número de elementos de cada tipo,
# dependeria de como lo implementasemos.

