library(rpart)
library(nnet)
library(e1071)
library(pROC)
set.seed(1)
#A
#Cargo dtrains
dtrain <- read.table("/home/mrjjavier/Descargas/train.csv", header=T, sep=",")
dtest <- read.table("/home/mrjjavier/Descargas/test.csv", header=T, sep=",")
dtrain$Survived <- as.factor(dtrain$Survived)

#Elimino columnas de los dtrains
dtest$PassengerId <- NULL
dtrain$PassengerId <- NULL
dtest$Cabin <- NULL
dtrain$Cabin <- NULL
dtest$Embarked <- NULL
dtrain$Embarked <- NULL
dtest$Fare <- NULL
dtrain$Fare <- NULL
dtest$Ticket <- NULL
dtrain$Ticket <- NULL
dtest$SibSp <- NULL
dtrain$SibSp <- NULL
dtest$Parch <- NULL
dtrain$Parch <- NULL
dtest$Name <- NULL
dtrain$Name <- NULL

#B
#Quito los atributos que sean NA
dtrain <- dtrain[!is.na(dtrain$Age),]
dtest  <- dtest[!is.na(dtest$Age),]


# Organizo para el vc
ind = sample(1:nrow(dtrain), nrow(dtrain), replace = F)
datosTraining <- dtrain[1:floor(length(ind)*.90),]
datosValidacion <- dtrain[(floor(length(ind)*.90)+1):length(ind),]

#svm e1071
msv <- svm(Survived ~ ., datosTraining, kernel="linear")
# Calculo la prediccion y el accuracy
msv_prediction <- predict(msv, newdata=datosValidacion)
matriz_confusion_msv<- table(msv_prediction, datosValidacion$Survived)
msv_accuracy<- sum(diag(matriz_confusion_msv)) / sum(matriz_confusion_msv)

#Perceptron nnet
perceptron_Multicapa <- nnet(Survived ~ .,data = datosTraining,size=8, maxit=1000, decay=5e-4)
# Calculo la prediccion y el accuracy
perceptron_prediction <- predict(perceptron_Multicapa, newdata=datosValidacion)
matriz_confusion_perceptron <- table(perceptron_prediction, datosValidacion$Survived)
perpectron_accuracy <- (sum(diag(matriz_confusion_perceptron)) / sum(matriz_confusion_perceptron))
auc_perceptron <- auc((datosValidacion$Survived==1),perceptron_prediction[,1])
perpectron_accuracy
auc_perceptron

#Arbol Rpart
rpart_tree <- rpart(Survived ~ ., data=datosTraining)
# Calculo la prediccion y el accuracy
rpart_prediction <- predict(rpart_tree, newdata = datosValidacion, type="class")
rpart_matriz_confusion <- table(rpart_prediction, datosValidacion$Survived)
rpart_accuracy <- sum(diag(rpart_matriz_confusion)) / sum(rpart_matriz_confusion)
rpart_accuracy


msv_accuracy
perpectron_accuracy
rpart_accuracy
# El arbol Rpart ha obtenido la mejor accuracy

#C

# arbol Rpart prune
opt <- which.min(rpart_tree$cptable[,"xerror"])
cp1 <- rpart_tree$cptable[opt, "CP"]
rpart_tree_prune <- prune(rpart_tree, cp=cp1)
rpart_prediction_prune <- predict(rpart_tree_prune , newdata = datosValidacion, type="class")
rpart_matriz_confusion_prune <- table(rpart_prediction_prune, datosValidacion$Survived)
rpart_accuracy_prune <- sum(diag(rpart_matriz_confusion_prune)) / sum(rpart_matriz_confusion_prune)


# Perceptron nnet capas dobladas

perceptron_Multicapa_doble <- nnet(Survived ~ .,data = datosTraining,size=16, maxit=1000, decay=5e-4)
perceptron_prediction_doble <- predict(perceptron_Multicapa_doble, newdata=datosValidacion, type="class")
matriz_confusion_perceptron_doble <- table(perceptron_prediction_doble, datosValidacion$Survived)
perpectron_accuracy_doble <- (sum(diag(matriz_confusion_perceptron_doble)) / sum(matriz_confusion_perceptron_doble))


#svm e1071 cambio kernel
msv <- svm(Survived ~ ., datosTraining, cost=10, kernel="polynomial", )
matriz_confusion_msv<- table(predict(msv, datosValidacion), datosValidacion$Survived)
msv_accuracy <- sum(diag(matriz_confusion_msv)) / sum(matriz_confusion_msv)

# Nuevas precisiones
rpart_accuracy_prune
perpectron_accuracy_doble
msv_accuracy


