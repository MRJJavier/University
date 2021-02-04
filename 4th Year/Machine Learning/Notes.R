# 19/10/2020
library(rpart)
df<-data.frame(x=c(1,2,3,3,3),y=factor(c("a","a","b","a","b")),z=c(5,4,4,2,5))
mytree<-rpart(y~x+z ,data=df,minbucket=1,minsplit=1)
summary(mytree)
printcp(mytree)
plot(mytree)
text(mytree,use.n=TRUE)
opt<-which.min(mytree$cptable[,"xerror"])
cp<-mytree$cptable[opt,"CP"]
prune<-prune(mytree,cp=cp) 
print(prune) 

#21/10/2020

library(party)
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.8, 0.2))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]
myFormula <- Species ~ .
arbol_party <- ctree(myFormula, data=trainData)
matrizconfusion <- table(predict(arbol_party), trainData$Species)
print(arbol_party)
plot(arbol_party, type="simple")
prediccion <- predict(arbol_party, newdata=testData)
#table(prediccion, testData$Species)
accuracy <- sum(diag(matrizconfusion))/sum(matrizconfusion)
accuracy

library(rpart)
arbol_rpart <- rpart(myFormula,data=trainData, method="class")
matrizconfusion_rpart <- table(predict(arbol_rpart, type="class"), trainData$Species)
prediccion_rpart <- predict(arbol_rpart, newdata=testData, type="class")
accuracy_rpart <- sum(diag(matrizconfusion_rpart))/sum(matrizconfusion_rpart)
accuracy_rpart

#26/10/2020

library(rpart)
data("kyphosis")
myFormula <- Kyphosis ~ .
kyphosis_rpart <- rpart(myFormula, data = kyphosis, control = rpart.control(minsplit = 10))
plot(kyphosis_rpart)
text(kyphosis_rpart, use.n=TRUE)
opt <- which.min(kyphosis_rpart$cptable[,"xerror"])
cp <- kyphosis_rpart$cptable[opt, "CP"]
kyphosis_rpart$cptable
kyphosis_prune <- prune(kyphosis_rpart, cp=cp)
#plot(kyphosis_prune)
#No pinta kyphosis_prune porque es root
print(kyphosis_prune)
kyphosis_prune <- prune(kyphosis_rpart, cp=0.05882353)
plot(kyphosis_prune)
text(kyphosis_prune, use.n=TRUE)
print(kyphosis_prune)


#28/10/2020
library(rpart)
library (party)
recidiva <- read.csv("/home/mrjjavier/Escritorio/recidiva.csv", sep="")
ind <- sample(2, nrow(recidiva), replace=TRUE, prob=c(0.8, 0.2))
dtrain <- recidiva[ind==1,]
dtest <- recidiva[ind==2,]
formularecidiva<- recid ~.
#RPART
arbolrecidiva<-rpart (formularecidiva, data=dtrain )
testPred <- predict(arbolrecidiva, newdata = dtest, type="class")
matrizconfusion<-table(testPred, dtest$recid)
accuracy<-sum(diag(matrizconfusion))/sum(matrizconfusion)
cat("Rpart: ",accuracy)
#Party
arbolrecidivaParty<-ctree(formularecidiva, data=dtrain)
testPred <- predict(arbolrecidivaParty, newdata = dtest, type="response")
matrizconfusion<-table(testPred, dtest$recid)
accuracy<-sum(diag(matrizconfusion))/sum(matrizconfusion)
cat("Party: ",accuracy)
#PODA
opt <- which.min(arbolrecidiva$cptable[,"xerror"])
cp1 <- arbolrecidiva$cptable[opt, "CP"]
arbolpodado<-prune (arbolrecidiva, cp=0.03508772)
testPred <- predict(arbolpodado, newdata = dtest, type="class")
matrizconfusion<-table(testPred, dtest$recid)
accuracy<-sum(diag(matrizconfusion))/sum(matrizconfusion)
cat("Rpart Podado: ",accuracy)

#04/11/2020
#lm
year <- rep(2008:2010, each = 4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)
plot(cpi, xaxt="n", ylab="CPI", xlab="")
# draw x-axis, where "las=3" makes text vertical
axis(1, labels=paste(year,quarter,sep="Q"), at=1:12, las=3)
cor(year, cpi)
cor(quarter, cpi)
fit <- lm(cpi ~ year + quarter)
fit
#esto no se usa
cpi2011 <- fit$coefficients[[1]] +
  fit$coefficients[[2]] * 2011 +
  fit$coefficients[[3]] * (1:4)
cpi2011
cpi2011 <- fit$coefficients[[1]] +
  fit$coefficients[[2]] * 2011 +
  fit$coefficients[[3]] * 3
cpi2011
#fin esto no se usa
data2011 <- data.frame(year=2011, quarter=1:4)
cpi2011 <- predict(fit, newdata=data2011)
cpi2011

#glm
year <- rep(2008:2010, each = 4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)
fitglm <- glm(cpi ~ year + quarter)
data2011 <- data.frame(year=2011, quarter=1:4)
cpi2011 <- predict(fitglm, newdata=data2011)
cpi2011

#nnet
library(nnet)
library(pROC)
datos <- read.table("/home/mrjjavier/Escritorio/recidiva.csv", header=T, quote="\"")
set.seed(123)
ind<-sample(500,500)
idt <- ind[1:10]
dtrain <- datos[-idt,]
dtest <- datos[idt,]
perceptronMulticapa <- nnet(recid~., data=dtrain, size=5, maxit=1000, decay=5e-4)
perceptronMulticapa
predPM <- predict(perceptronMulticapa, dtest, type="raw")
predPM
areabajocurva <- auc((dtest$recid=="SI"),predPM[,1])
areabajocurva


#16/11/2020
library(e1071)
library(rpart)
set.seed(100)
ind <- sample(150,150)
idt <- ind[1:10]
dtrain <- iris[-idt,]
dtest <- iris[idt,]
m1 <- svm(Species ~ ., data = dtrain, kernel = "linear")
matrizconfusionSVM<-table(predict(m1,dtest), dtest$Species, dnn=c("Prediction", "Actual"))
accuracySVM<- sum(diag(matrizconfusionSVM))/sum(matrizconfusionSVM)

tree<-rpart (Species ~ ., data = dtrain, method="class")
t_pred = predict(tree,dtest,type="class")

matrizconfusionRPART <- table(dtest$Species, t_pred)
accuracyRPART<- sum(diag(matrizconfusionRPART))/sum(matrizconfusionRPART)

matrizconfusionSVM
matrizconfusionRPART
accuracySVM
accuracyRPART

#18/11/2020
#kernlab

require('kernlab')

kfunction <- function(linear =0, quadratic=0)
{
  k <- function (x,y)
  {
    linear*sum((x)*(y)) + quadratic*sum((x^2)*(y^2))
  }
  class(k) <- "kernel"
  k
}
x = c(0,4)
y = c(0,4)
Z = c(1,2)
x1 = matrix(cbind(x,y),,2)
svp <- ksvm(x1,Z,type="C-svc",C = 100, kernel=kfunction(1,0),scaled=c())

#svp <- ksvm(datos$Z~.,data=datos,type="C-svc",C = 100, kernel=kfunction(1,0),scaled=c())


plot(c(min(x1[,1]), max(x1[,1])),c(min(x1[,2]), max(x1[,2])),type='n',xlab='x1',ylab='x2')
title(main='Linear Separable Features')
ymat <- ymatrix(svp)
points(x1[-SVindex(svp),1], x1[-SVindex(svp),2], pch = ifelse(ymat[-SVindex(svp)] < 0, 2, 1))
points(x1[SVindex(svp),1], x1[SVindex(svp),2], pch = ifelse(ymat[SVindex(svp)] < 0, 17, 16))

# Extract w and b from the model
w <- colSums(coef(svp)[[1]] * x1[SVindex(svp),])
b <- b(svp)

# Draw the lines
abline(b/w[2],-w[1]/w[2])
abline((b+1)/w[2],-w[1]/w[2],lty=2)
abline((b-1)/w[2],-w[1]/w[2],lty=2)

#23/11/2020
#Enero2019 3
#A
library(kernlab)
library(ggplot2)
x1 <- c(1,3,1,3,2,3,4)
x2 <- c(1,3,3,1,2.5,2.5,3)
y  <- c(-1,1,1,-1,1,-1,-1)
matriz = matrix(cbind(x1,x2),,2)
dfA <- data.frame(x1,x2,y)
plot(x1,x2)
ggplot(dfA, aes(x=x1,y=x2,color=y)) + geom_point(size=4)
svp <- ksvm(matriz,y, type="C-svc", C=100, kernel="vanilladot")
svp
#vector de pesos normal al hiperplano
w <- colSums(coef(svp)[[1]] * matriz[SVindex(svp),])
w
#calcular la anchura del canal
width <- 2/(sum(sqrt((w)^2)))
width
b <- b(svp)
b

vectores.soporte <- data.frame(X1=matriz[SVindex(svp),1],Y1=matriz[SVindex(svp),2])
#representacion grafica
plot(c(min(matriz[,1]), max(matriz[,1])),c(min(matriz[,2]), max(matriz[,2])),type='n',xlab='x1',ylab='x2')
title(main="Linearmente separable")

points(matriz[-SVindex(svp),1], matriz[-SVindex(svp),2])
points(matriz[SVindex(svp),1], matriz[SVindex(svp),2])

abline(b/w[2],-w[1]/w[2])
abline((b+1)/w[2],-w[1]/w[2],lty=2)
abline((b-1)/w[2],-w[1]/w[2],lty=2)

#B
library(e1071)
dfB <- data.frame(
  x1 = c(1,3,1,3,2,3,4,1.5,1),
  x2 = c(1,3,3,1,2.5,2.5,3,1.5,2),
  y  = c(-1,1,1,-1,1,-1,-1,1,-1)
)
dfB$y <- as.factor(dfB$y)
ggplot(dfB, aes(x=x1,y=x2,color=y)) + geom_point(size=4)

svmB <- svm(y~., dfB, kernel="polynomial", C=10, degree=2)
svmB

#vectores soporte
vsB <- dfB[svmB$index,1:2]
vsB
#vector de pesos normal al hiperplano
wB <- crossprod(as.matrix(vsB),svmB$coefs)
#calcular la anchura del canal
widthB <- 2/(sum(sqrt((wB)^2)))
bB<- svmB$rho
bB

#representacion grafica
plot(svmB, dfB)

paste(c("[",wB,"]' * X + [",bB,"] = 0"), collapse=" ")
paste(c("[",wB,"]' * X + [",bB,"] = 1"), collapse=" ")
paste(c("[",wB,"]' * X + [",bB,"] = -1"), collapse=" ")




#Enero2019 2
library(rpart)
voteTraining <- read.table("/home/mrjjavier/Escritorio/vote/voteTraining.test", header=FALSE, sep=",")
vote <- read.table("/home/mrjjavier/Escritorio/vote/vote.data", header=FALSE, sep=",")
names(voteTraining)<-c("handicappedinfants",
                       "waterprojectcostsharing",
                       "adoptionofthebudgetresolution",
                       "physicianfeefreeze",
                       "elsalvadoraid",
                       "religiousgroupsinschools",
                       "antisatellitetestban",
                       "aidtonicaraguancontra",
                       "mxmissile",
                       "immigration",
                       "synfuelscorporationcutback",
                       "educationspending",
                       "superfundrighttosue",
                       "crime",
                       "dutyfreeexports",
                       "exportadministrationactsouthafrica", "votation")

vote <- read.table("/home/mrjjavier/Escritorio/vote/vote.data", header=FALSE, sep=",")
names(vote)<-c("handicappedinfants",
               "waterprojectcostsharing",
               "adoptionofthebudgetresolution",
               "physicianfeefreeze",
               "elsalvadoraid",
               "religiousgroupsinschools",
               "antisatellitetestban",
               "aidtonicaraguancontra",
               "mxmissile",
               "immigration",
               "synfuelscorporationcutback",
               "educationspending",
               "superfundrighttosue",
               "crime",
               "dutyfreeexports",
               "exportadministrationactsouthafrica", "votation")
vote$physicianfeefreeze <- NULL
voteTraining$physicianfeefreeze <- NULL

tree <- rpart(votation ~., data=vote)
#Dibujar el arbol
plot(tree)
text(tree,use.n=TRUE)
#imprimir cptable
printcp(tree)
#obtener el CP
opt<-which.min(tree$cptable[,"xerror"])
cp<-tree$cptable[opt,"CP"]
cp
#podar el arbol
treeprune<-prune(tree,cp=cp) 
print(treeprune)
plot(treeprune)
text(treeprune,use.n=TRUE)

#Prediccion con ambos arboles
prediccion_tree <- predict(tree, newdata=voteTraining, type="class")
prediccion_treeprune <-predict(treeprune, newdata=voteTraining, type="class")

#Calculo matriz de confusion
matrizconfusion_tree <- table(prediccion_tree, voteTraining$votation)
matrizconfusion_treeprune <- table(prediccion_tree, voteTraining$votation)

#Accuracy ambos arboles
accuracy_tree<-sum(diag(matrizconfusion_tree))/sum(matrizconfusion_tree)
accuracy_treeprune<-sum(diag(matrizconfusion_treeprune))/sum(matrizconfusion_treeprune)

accuracy_tree
accuracy_treeprune

