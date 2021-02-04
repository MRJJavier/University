library(readr)
library(dplyr)
library(data.tree)

entropiaCondicional <- function(dataset, atributo, valor){

  conjuntoFiltrado <- filter(dataset, dataset[atributo]==valor)
  totales <- count(conjuntoFiltrado, conjuntoFiltrado[dim(conjuntoFiltrado)[2]])
  totales <- totales[2]
  total <- sum(totales[dim(totales)[2]])
  fracciones <- totales$n/total
  entropia <- sum(fracciones*log2(fracciones))*(-1)
  
  return(entropia)
}

Entropy <- function(df,attribute){
  
  totales <- count(df[attribute], df[dim(df)[2]])
  totales <- totales[2]
  total <- sum(totales[dim(totales)[2]])
  fracciones <- totales$n/total
  entropy <- sum(fracciones*log2(fracciones))*(-1)
  
  return(entropy)
}

ganancia <- function (dataframe, target, atributo) {
  
  clases <- unique(dataframe[atributo])[[1]]
  sum = 0
  for (c in clases) {
    sum <- sum + count(dataframe[atributo], dataframe[atributo] == c)$n[2] / dim(dataframe[atributo])[1] * entropiaCondicional(dataframe, atributo, c)
  }
  g <- Entropy (dataframe, target) - sum
  
  return (g)
}

atributoEscoger <- function (dataset){
  
  nombres <- names(dataset)
  objetivo <- nombres[length(nombres)]
  atributos <- nombres[1:length(nombres)-1]
  max <- 0
  
  for (a in atributos) {
    ganancia <- ganancia(dataset,objetivo,a)
    if(is.na(ganancia)){
      ganancia<-0
    }
    if(ganancia > max){
        max <- ganancia
        atributo <- a
    }
  }
  mejorAtributo <- atributo
  
  return(mejorAtributo)
}

recortarDataset <- function (dataset, columna, clase){
  
  datos2 <- filter(dataset, dataset[columna]==clase)
  datos2[columna] <- NULL
  
  return(datos2)
}

arbolRecursivo <- function (dataset, objetivo){
  
  #print("Nivel nuevo")
  mAtributo <- atributoEscoger(dataset)
  clases <- unique(dataset[mAtributo])[[1]]
  arbol <- Node$new(mAtributo)
  
  for(x in clases){
    rama <- arbol$AddChild(x)
    datosPodados <- recortarDataset(dataset, mAtributo, x)
    salidas <- unique(datosPodados[objetivo])[[1]]
    if(length(salidas)==1){
      hijo <- rama$AddChild(salidas)
    }else{
      hijo <- rama$AddChildNode(arbolRecursivo(datosPodados, objetivo))
    }
  }
  
  return(arbol)
}

learnDT <- function(csv){
  
  datos <- read_delim(csv, ";", escape_double = FALSE, trim_ws = TRUE)
  nombres <- names(datos)
  objetivo <- nombres[length(nombres)]
  arbol <- arbolRecursivo(datos, objetivo)

  return(arbol)
}

drawDecisionTree <- function(arbol){
  
  print(arbol)
  plot(arbol)
  
}

clasificaDato <- function(arbol, dato){
  
  while(!arbol$isLeaf){
    #print(unlist(dato[1,arbol$name]))
    arbol <- arbol$RemoveChild(unlist(dato[1,arbol$name]))
    #print(unlist(arbol$children[[1]]$name))
    arbol <- arbol$RemoveChild(unlist(arbol$children[[1]]$name))
  }
  
  return(arbol$name)
}

clasificador <- function(arbol, dtest){
  
  clasificaciones <- c()
  for(i in 1:dim(test)[1]){
    #print(i)
    r <- clasificaDato(Clone(arbol),dtest[i,])
    clasificaciones <- c(clasificaciones,r)  
  }
  
  return(clasificaciones)
}

csv <- "datos2.csv"
arbolito <- learnDT(csv)
drawDecisionTree(arbolito)
csv <- "test2.csv"
test <- read_delim(csv, ";", escape_double = FALSE, trim_ws = TRUE)
final <- clasificador(arbolito,test)
final
test[length(test)]
final == test[length(test)]





