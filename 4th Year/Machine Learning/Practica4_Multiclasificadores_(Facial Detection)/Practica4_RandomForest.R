library("rpart")
library("randomForest")

#Cargo los datos ya tratados.
load(file="datosTratados.Rd")

#Preparación dataframes para almacenar los datos necesarios
colnamesPredict <- c("left_eye_center_x","left_eye_center_y","right_eye_center_x","right_eye_center_y","nose_tip_x","nose_tip_y")
predicciones <- data.frame(matrix(NA,nrow=dim(test)[1],ncol=length(colnamesPredict)))
distanciaEuclideaPuntos <- data.frame(matrix(NA,nrow=dim(test)[1],ncol=length(colnamesPredict)/2))
colnames(distanciaEuclideaPuntos) = c("left_eye_center","right_eye_center","nose_tip")
colnames(predicciones) = colnamesPredict
mseFeatures <- data.frame(matrix(nrow=1,ncol=length(colnamesPredict)))
colnames(mseFeatures) = colnamesPredict
msePredicionDatos <- data.frame(matrix(nrow=dim(test)[1],ncol=1))

#Para cada Feature a predecir, creo un Random Forest, guardo todas las predicciones de ese Feature
# y calculo el error cuadrático medio de las predicciones de ese RF.
for (j in colnamesPredict){
    rf <- randomForest(formula = as.formula(paste(j," ~ .")), data=train, ntree=100)
    predicciones[,j] <- predict(rf,newdata=test)
    mseFeatures[,j] <- sum((test[,j]-predicciones[,j])^2)/dim(test)[1]
}


# Calculo distancia euclidea de los puntos predecidos a los puntos dados
aux <- (test[,colnamesPredict]-predicciones)^2

for(i in 1:length(distanciaEuclideaPuntos)){
  distanciaEuclideaPuntos[,i]=sqrt(aux[,2*i-1]+aux[,2*i])
}
# Calculo el error cuadrático medio de cada dato de test
msePredicionDatos <- rowSums(aux)

# Muestro el error cuadrático medio de los RandomForest por Features
print("Error cuadrático medio de los RandomForest por Features: ")
mseFeatures

#Funcion que muestra el dato i de test con su prediccion y su error cuadrático medio
mostrarUnDato <- function(i){
  cat("Imagen con puntos y predicción número: ",i,"\n")
  #Muestro la imagen
  im <- as.character(test[i,31])
  im <- as.integer(unlist(strsplit(im, " ")))
  im <- matrix(data=rev(im), nrow=96, ncol=96)
  image(1:96, 1:96, im, col=gray((0:255)/255))
  
  #Imprimo los puntos ya dados
  points(96-test$nose_tip_x[i],         96-test$nose_tip_y[i],         col="red")
  points(96-test$left_eye_center_x[i],  96-test$left_eye_center_y[i],  col="red")
  points(96-test$right_eye_center_x[i], 96-test$right_eye_center_y[i], col="red")
  
  #Imprimo los puntos de prediccion
  points(96-predicciones$nose_tip_x[i],         96-predicciones$nose_tip_y[i],         col="green")
  points(96-predicciones$left_eye_center_x[i],  96-predicciones$left_eye_center_y[i],  col="green")
  points(96-predicciones$right_eye_center_x[i], 96-predicciones$right_eye_center_y[i], col="green")
  
  cat("Distancia euclidea puntos ojo izquierdo: ", distanciaEuclideaPuntos$left_eye_center[i],"\n")
  cat("Distancia euclidea puntos ojo derecho: ", distanciaEuclideaPuntos$right_eye_center[i],"\n")
  cat("Distancia euclidea puntos de la nariz: ", distanciaEuclideaPuntos$nose_tip[i],"\n")
  
  title(paste("Error cuadrático medio: ",msePredicionDatos[i]))
  cat("Error cuadrático medio de esta predicción: ",msePredicionDatos[i],"\n\n")
}

#Funcion que muestra los n primeros datos de test con su prediccion y su error cuadrático medio
mostrarPrimerosNDatos <- function(n){
  for(i in 1:n){
    mostrarUnDato(i)
    Sys.sleep(3)
  }
}

mostrarUnDato(1)
#mostrarPrimerosNDatos(dim(test)[1])

cat("Media de todos los errores cuadrático medio de las predicciones de datos: ", sum(msePredicionDatos)/length(msePredicionDatos))





