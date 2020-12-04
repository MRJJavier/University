# José Javier Morente Risco
# Práctica 2. 1º Parte
# Implementar en R:

# a) Códigos de longitud constante
# Parámetro D: Vector cuyos elementos son los simbolos del alfabeto
# Parámetro n: Numéro constante de mensajes por unidad de tiempo que emite la fuente de información
CLC <- function(D,n) {
  L <- ceiling(log2(n)/log2(length(D)))
  # Se calcula la longitud que tendrán las palabras código
  replist <- rep(list(D),L)
  # Se crea un vector de listas del alfabeto, con longitud L
  combinaciones <- expand.grid(replist)
  # Se crea un data frame con todas las posibles combinaciones del vector replist
  clc <- combinaciones[1:n,1:L]
  # Modifico el data frame para que solo muestre los códigos necesarios, según n
  return(clc)
  # Devuelve el codigo de longitud constante
}

# a) Ejemplos
# Variables
# > alfabeto1 <- (0:1)
# > alfabeto2 <- (0:2)
# > n1 <- 8
# > n2 <- 6

# Entrada
# > CLC(alfabeto1,n1)
# Salida
# Var1 Var2 Var3
# 1    0    0    0
# 2    1    0    0
# 3    0    1    0
# 4    1    1    0
# 5    0    0    1
# 6    1    0    1
# 7    0    1    1
# 8    1    1    1

# Entrada
# > CLC(alfabeto1,n2)
# Salida
# Var1 Var2 Var3
# 1    0    0    0
# 2    1    0    0
# 3    0    1    0
# 4    1    1    0
# 5    0    0    1
# 6    1    0    1

# Entrada
# > CLC(alfabeto2,n1)
# Salida
# Var1 Var2
# 1    0    0
# 2    1    0
# 3    2    0
# 4    0    1
# 5    1    1
# 6    2    1
# 7    0    2
# 8    1    2

# Entrada
# > CLC(alfabeto2,n2)
# Salida
# Var1 Var2
# 1    0    0
# 2    1    0
# 3    2    0
# 4    0    1
# 5    1    1
# 6    2    1

# b) Calcular la longitud media de un código
# Parámetro c: Vector cuyos elementos son codificaciones de los mensajes
# Parámetro p: Vector cuyos elementos son las probabilidades de que se transmita los mensajes
LMed <- function(c,p){
  lmed <- 0
  # Inicializo una variable para acumular
 for(i in 1:length(c)){
   lmed <- lmed + nchar(c[i])*p[i]
   #  Multiplico la longitud de cada código por la probabilidad y la acumulo
 }
  return(lmed)
  # Devuelvo la acumulacion
}

# b) Ejemplos
# Variables
# > codigo1 <- c('00','01','10','11')
# > codigo2 <- c('0','10','110','111')
# > p1 <- c(0.25,0.25,0.25,0.25)
# > p2 <-c(0.4,0.3,0.15,0.15)

# Entrada
# > LMed(codigo1,p1)
# Salida
# [1] 2

# Entrada
# > LMed(codigo2,p2)
# Salida
# [1] 1.9

# c) Verificar la desigualdad de Kraft
# Parámetro D: Vector cuyos elementos son los simbolos del alfabeto
# Parámetro c: Vector cuyos elementos son codificaciones de los mensajes
DKraft <- function(D,c){
  dkraft <-0
  # Inicializo una variable para acumular
  for(i in 1:length(c)){
    dkraft <- dkraft + (1/length(D))^nchar(c[i])
    # Calculo la inversa del tamaño del alfabeto y lo elevo a la longitud de cada codigo
    # acumulandolo en cada iteracion
  }
  return(dkraft <= 1)
  # Devuelve un valor booleano que sera TRUE si la acumulación es menor o igual a 1
}

# c) Ejemplos
# Ejemplo diapositiva numero 14
# Variables
# > alfabeto <- (0:1)
# > codigo <- c('100','010','000','111','101','110')
# Entrada
# > DKraft(alfabeto,codigo)
# Salida
# [1] TRUE

#Funciones utilizadas

# ceiling(). Funcion que redondea por exceso al siguiente natural
# rep(). Replica lo que se haya pasado como parametro, puede especificarse el numero de veces.
# expand.grid(). Crea un data frame con todas las combinaciones del vector pasado como parametro.
# nchar(). Devuelve la longitud de una cadena de caracteres



# HuffmanGeneralizado <- function(D,p){
#   alfabeto <- c(0:(D-1))
#   codigo <- vector(length = length(p))
#   while(length(p)!=1){
#     #Se repite hasta que solo quede una probabilidad
#     sort(p, decreasing = TRUE)
#     #Ordena el vector de probabilidades
#     if(sum(p<0 | p>1)>0 | sum(p)!=1){ 
#       return("NaN")
#       #Si la suma de las probabilidades de p mayores de 1 o menores de 0 es mayor que 0 
#       #o la suma de todas las probabilidades de p es distinta a 1
#       #devuelve un NaN (Not a Number)
#     }else{
#       r= trunc((length(p)-2)%%(D-1)) + 2
#       #Calcula el r +2
#       cont <- 1
#       #Variable contador para el vector alfabeto
#       for(i in 1:length(p)){
#          #Bucle para asignar los simbolos del alfabeto a los mensajes
#         if(i+r <= length(p)){
#           codigo[i] = ""
#         } else{
#           codigo[i] <- alfabeto[r+cont]
#           cont <- cont + 1
#         }
#       }
#       sum <- 0
#       #Variable que guarda la suma de las probabilidades que se van a unir
#       for(i in length(p)-cont:length(p)){
#         sum <- sum + p[i]
#       }
#       
#       p <- p[1:(length(p)-cont+2)]
#       #Acorta el vector de probabilidades
#       p[(length(p)-cont+2)] = sum
#       #Se añade la probabilidad acumulada en sum
#     }
#   }
#     return(codigo)
# }
 

  # José Javier Morente Risco
  # Práctica 2. 2º Parte
  # Implementar en R:
  
  # Algoritmo huffman(generalización)
  # Condiciones que deben cumplirse:
  #   1ºCalcular el resto r
  #   2ºProbabilidades sumen 1
  # Ejemplo: D=4
  #          Probabilidades: {0.25,0.25,0.126,0.124,0.0625,0.0625,0.0625,0.0625}
  
  #Parámetro S: Alfabeto de entrada
  #Parámetro p: Vector de probabilidades
  HuffmanGeneralizado <- function(S, p) {
    if(sum(p<0 | p>1)>0 | sum(p)!=1) return("ERROR")
    #Controlo los posibles casos de error del vector de probabilidades
    #2º Condición: Probabilidades sumen 1
    if (length(p)==1) return(c())
    #Condición de salida para llamada recursiva.
    D = length(S)
    #Guardo la longitud del alfabeto
    n = length(p)
    #Guardo la longitud del vector de probabilidades
    r = (n-2)%%(D-1)
    #Calculo r
    #1º Condición: Calcular el resto r
    posicionmin = c()
    valormin = c()
    #Inicialización de las variables
    for (i in 1:(r+2)) {
      #Creación de la agrupación de los r+2 menores
      posicionmin = append(posicionmin, which.min(p));
      #Guardo la posición del mínimo
      valormin = append(valormin, min(p))
      #Guardo el mínimo
      p = p[-posicionmin[i]]
      #Elimino el mínimo del vector de probabilidades
    }
    p = append(p, sum(valormin))
    #Añado la probabilidad de la agrupación al vector de probabilidades 
    codigo = HuffmanGeneralizado(S, p)
    #Se llama recursivamente a la función con el nuevo vector p
    
    asig = codigo[length(codigo)]
    #Guardo la asignación de la agrupación
    codigo = codigo[-length(codigo)]
    #La elimino del vector codigo
    for (i in 1:(r+2)) {
      codigo = append(codigo, paste(asig, S[D-i+1], sep=""))
    }
    #Asigno los códigos empezando por la asignación guardada
    return(codigo)
    #Devuelvo el código
  }
  
  #Ejemplos
  #Variables
  # > S1 = c(0,1,2)
  # > S2 = c(0,1,2,3)
  # > p = c(0.25,0.25,0.126,0.124,0.0625,0.0625,0.0625,0.0625)
  
  #Entrada
  #> HuffmanGeneralizado(S1,p)
  #Salida
  #[1] "2"    "1"    "02"   "01"   "002"  "001"  "0002" "0001"
  
  #Entrada
  #> HuffmanGeneralizado(S2,p)
  #Salida
  #[1] "3"   "2"   "1"   "03"  "02"  "01"  "003" "002"
  
  #Funciones usadas
  #which.min(). Devuelve la posición del minimo elemento del vector
  #append(). Añade a un vector un valor.
  #paste(). Concatena vectores convirtiendolos en caracter.
