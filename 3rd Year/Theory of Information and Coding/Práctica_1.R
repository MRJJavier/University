#a
vp <- c(1:100)/100  #Inicializa un vector con valores de 1 a 100 dividos entre 100.
n <- length(vp) #Guarda el tamaño del vector anterior en n
H <- array(0,n) #Inicializa un vector de tamaño n con todos sus valores a 0
for(i in 1:n) 
  H[i] <- vp[i]*log2(1/vp[i])+(1-vp[i])*log2(1/(1-vp[i]))
  #Guarda la entropia en la posicion i de cada valor i y el 1 - valor i
plot(vp,H,col="red",lwd=2,xlab="p",ylab="H",main= "H(X), 2 resultados posibles según prob. x1", type="l")
#Dibuja la gráfica de la entropia

#b
#Código función entropia. H(x)
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

#c
#Código función entropia compuesta. H(XxY)
HCompuestaXY<-function(p,q){
  result<-0 #Defino la variable donde se va a ir sumando los valores
  if((sum(p<0 | p>1)>0 | sum(p)!=1) & (sum(q<0 | q>1)>0 | sum(q)!=1)){
    return("NaN")
    #Si la suma de las probabilidades de p mayores de 1 o menores de 0 es mayor que 0 
    #o la suma de todas las probabilidades de p es distinta a 1
    #Y la suma de las probabilidades de q mayores de 1 o menores de 0 es mayor que 0 
    #o la suma de todas las probabilidades de p es distinta a 1
    #devuelve un NaN (Not a Number)
  }else{
    #En otro caso
    for(i in 1:length(p)){
      for(j in 1:length(q)){
        probpq<-p[[i]]*q[[i]]
        #probpq es la probabilidad de p multiplicada por la de q en cada posición
        #definido de esta manera para mejorar la legibilidad del codigo
        result<-result+(probpq*log2(1/probpq))
        #Para cada probabilidad de p y q, realiza la fórmula y se la suma a result
      }
    }
    return(result)
    #Una vez terminado los bucle devuelve result, donde result es el valor de la entropia compuesta
  }
}

#d
#Código función entropia condicionada H(X/Y)
#De la preposición 1 (diapositiva no.25) H(XxY) = H(Y) + H(X/Y)
#Se deduce H(X/Y) = H(XxY) -  H(Y)
HCondicionadaXY<-function(p,q){
  return(HCompuestaXY(p,q)-H(q))
}

#Código de la información mutua
#De la fórmula(diapositiva no.27) I(X,Y) = H(X) – H(X/Y) 
IMutua<-function(p,q){
  return(H(p)-HCondicionadaXY(p,q))
}


p<-c(0.1,0.9)
q<-c(0.5,0.5)
H(p)
H(q)
HCompuestaXY(p,q)
HCondicionadaXY(p,q)
IMutua(p,q)

# c() - Función que combina sus argumentos para formar un vector. Todos los argumentos son forzados a tomar el mismo tipo de dato.
# length() - Función que devuelve el tamaño del vector pasado por argumento.
# array() - Crea un array de elementos.
# log2() - Devuelve el logaritmo en base 2 del numero pasado por argumento.
# function() - Función que sirve como mecanismo base para definir nuevas funciones. 
# Sus argumentos son los que tomará la nueva función.
# sum() - Devuelve la suma de todos los valores pasados como argumento.
# if() - Función que el caso de que su argumento tome el valor booleano TRUE 	 	ejecutará el codigo en su interior.
# else - Solo aparecerá acompañando a la función if(). Ejecutará el codigo en su 	 	interior si el resto de casos son FALSE.
# return() - Devuelve el argumento en su interior. Suele ser usado en la definición 		   de nuevas funciones.
