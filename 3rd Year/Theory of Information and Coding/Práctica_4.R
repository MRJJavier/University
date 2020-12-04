# José Javier Morente Risco
# Práctica 4.
# Implementar en R:
#   1. Calcular la capacidad del canal
#   Mostrar:
#     Salida -> Valor capacidad
#       "    -> Probabilidades yj -> Bj
#       "    -> Probabilidades xi -> Ai
#   2. Regla de decodificación con minima probabilidad de error.
#   3. Regla de decodificación por máximaverosimilitud.
#   4. Segundo teorema de Shannon (Opcional)

#Código función entropia. H(x)
#Parámetro p: Vector de probabilidades
H<-function(p){
  result<-0 #Defino la variable donde se va a ir sumando los valores
  if(sum(p<0 | p>1)>0 | sum(p)!=1){ 
    return("NaN")
    #Si la suma de las probabilidades de p mayores de 1 o menores de 0 es mayor que 0 
    #o la suma de todas las probabilidades de p es distinta a 1
    #devuelve un NaN (Not a Number)
  }else{
    #En otro caso
    for (i in 1:length(p)) {
      result<-result+(p[i]*log2(1/p[i]))
      #Para cada probabilidad de p, realiza la fórmula y se la suma a result
    }
    return(result)
    #Una vez terminado el bucle devuelve result, donde result es el valor de la entropia
  }
}
#   1. Calcular la capacidad del canal
#   Mostrar:
#     Salida -> Valor capacidad
#       "    -> Probabilidades yj -> Bj
#       "    -> Probabilidades xi -> Ai

# Parámetro m: Una matriz de probabilidades
CapacidadyProbabilidades <- function(m){
  dim<-dim(m)
  #Guarda las dimensiones de la matriz pasada como parámetro.
  hs<-array(0,dim[1])
  #Se inicializa un vector para guardar las entropias de cada fila.
  for(i in 1:dim[1]){
    aux<-c()
    for(j in 1:dim[2]){
      if(m[i,j] > 0){
        aux<-cbind(aux,m[i,j])
      }
      #Se guardan las probabilidades mayores que 0 de cada fila en un vector auxiliar.
    }
    hs[i]<-H(aux)
    #Se realiza la entropia de las probabilidades guardadas en el vector auxiliar y se guarda en el vector inicializado.
  }
  res<-qr.solve(m,hs)
  #Se resuelve el sistema de ecuaciones con la matriz y las entropias
  aux<-c()
  for(i in 1:length(res)){
    aux[i] <- 1/2^res[i]
  }
  #Se almacena en un vector auxiliar para cada resultado del sistema de ecuaciones la operacion 1/2^res[i]
  capacidad<-log2(sum(aux))
  #Se haya la capacidad del canal realizando el log2 de la suma del vector auxiliar anterior.
  cat("Valor capacidad del canal:",capacidad," b/s \n")
  cat("Probabilidades yj -> Bj \n")
  aux2<-c()
  for(i in 1:length(aux)){
    aux2[i]<-(aux[i]/2^capacidad)
    cat("y")
    cat(i,"-> p(B")
    cat(i)
    cat("):",aux2[i],"\n")
  }
  #Calculo los yj -> p(Bj) y los guardo en un vector auxiliar 2
  #Estos se usaran para resolver el sistema de ecuaciones y hallar los xi -> p(Ai)
  maux<-t(m)
  #Guardo en una variable auxiliar la matriz traspuesta de la pasada como parametro.
  res2<-qr.solve(maux,aux2)
  #Se resuelve el sistema de ecuaciones con la matriz traspuesta y los yj
  cat("Probabilidades xi -> Ai \n")
  for(i in 1:length(res2)){
    cat("x")
    cat(i,"-> p(A")
    cat(i)
    cat("):",res2[i],"\n")
  }
}

#Ejemplo
#Variables
# > matriz <- rbind(c(0,0,2/5,3/5),c(1/2,1/2,0,0),c(0,0,1/4,3/4),c(1/3,2/3,0,0))
# > matriz
#           [,1]      [,2] [,3] [,4]
# [1,] 0.0000000 0.0000000 0.40 0.60
# [2,] 0.5000000 0.5000000 0.00 0.00
# [3,] 0.0000000 0.0000000 0.25 0.75
# [4,] 0.3333333 0.6666667 0.00 0.00

#Entrada
# > CapacidadyProbabilidades(matriz)

#Salida
# Valor capacidad del canal: 1.019676  b/s 
# Probabilidades yj -> Bj 
# y1 -> p(B1): 0.2080801 
# y2 -> p(B2): 0.2922826 
# y3 -> p(B3): 0.1616206 
# y4 -> p(B4): 0.3380166 
# Probabilidades xi -> Ai 
# x1 -> p(A1): 0.244742 
# x2 -> p(A2): 0.2477552 
# x3 -> p(A3): 0.2548953 
# x4 -> p(A4): 0.2526076

#   2. Regla de decodificación con minima probabilidad de error.
#Parámetro m: Una matriz de probabilidades
#Parámetro p: Vector de probabilidades
DecMinProbErr<-function(m, p){
  dim<- dim(m)
  #Se guardan las dimensiones de la matriz
  for (i in 1:dim[1]){
    m[i,]<- m[i,]*p[i]
  }
  #Se calcula la matriz de probabilidades compuestas p(Ai,Bj)
  maux<-m
   for (i in 1:dim[1]){
     for (j in 1:dim[2]){
       m[i,j]<- maux[i,j]/sum(maux[,j])
     }
   }
  #Se calcula la matriz de probabilidades condicionadas p(Ai/Bj) = p(Ai,Bj)/P(Bj) 
  m<-t(m)
  #Se realiza la traspuesta a la matriz de probabilidades condicionadas
  for(i in 1:dim[2]){
    cat("f(B")
    cat(i)
    cat(") = A")
    cat(which.max(m[i,]),"\n")
  }
  #Comprueba en que posición de la matriz p(Ai/Bj) el valor es máximo y lo imprime por pantalla
}

#Ejemplos
#Variables
# > matriz2 <- rbind(c(1/3,1/9,5/9),c(1/6,2/6,3/6))
# > matriz2
# [,1]      [,2]      [,3]
# [1,] 0.3333333 0.1111111 0.5555556
# [2,] 0.1666667 0.3333333 0.5000000
# > probs <- c(1/2,1/2)
# > probs
# [1] 0.5 0.5
# > probs2 <- c(3/4,1/4)
# > probs2
# [1] 0.75 0.25

#Entrada
# > DecMinProbErr(matriz2,probs)
#Salida
# f(B1) = A1 
# f(B2) = A2 
# f(B3) = A1 

#Entrada
# > DecMinProbErr(matriz2,probs2)
#Salida
# f(B1) = A1 
# f(B2) = A1 
# f(B3) = A1 

#   3. Regla de decodificación por máximaverosimilitud.
#Parámetro m: Una matriz de probabilidades
#Parámetro p: Vector de probabilidades
DecMaxVeSim<-function(m, p){
  dim <- dim(m)
  for(i in 1:dim[2]){
    cat("f(B")
    cat(i)
    cat(") = A")
    cat(which.max(m[,i]),"\n")
  }
  #Comprueba en qué posición de la matriz p(Bj/Ai) el valor es máximo
  if(max(p)==min(p)){
    cat("La distribución inicial es equiprobable, coincide con la de mínima probabilidad de error. ")
  } else {
    cat("La distribución inicial es NO equiprobable, NO tiene porqué coincidir con la de mínima probabilidad de error.")
  }
}

#Ejemplos
#Variables
# > matriz2 <- rbind(c(1/3,1/9,5/9),c(1/6,2/6,3/6))
# > matriz2
# [,1]      [,2]      [,3]
# [1,] 0.3333333 0.1111111 0.5555556
# [2,] 0.1666667 0.3333333 0.5000000
# > probs <- c(1/2,1/2)
# > probs
# [1] 0.5 0.5
# > probs2 <- c(3/4,1/4)
# > probs2
# [1] 0.75 0.25

#Entrada
# > DecMaxVeSim(matriz2,probs)
#Salida
# f(B1) = A1 
# f(B2) = A2 
# f(B3) = A1 
# La distribución inicial es equiprobable, coincide con la de mínima probabilidad de error. 
#Entrada
# > DecMaxVeSim(matriz2,probs2)
#Salida
# f(B1) = A1 
# f(B2) = A2 
# f(B3) = A1 
# La distribución inicial es NO equiprobable, NO tiene porqué coincidir con la de mínima probabilidad de error.

#Funciones usadas
#cat(). Imprime por pantalla
#which.max(). Devuelve la posición del máximo elemento del vector
