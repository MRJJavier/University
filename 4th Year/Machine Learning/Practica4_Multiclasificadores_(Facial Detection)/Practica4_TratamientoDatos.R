#Tratamiento del dataset inicial
set.seed(10)
d.dataset <- read.csv("training.csv", stringsAsFactors=F)
data <- na.omit(d.dataset)
mezcla <- sample(dim(data)[1],dim(data)[1])
separacion <- ceiling(dim(data)[1]*0.2)
ind <- mezcla[1:separacion]
test <- data[ind,]
train  <- data[-ind,]
train$Image <- NULL

save(train, test, file='datosTratados.Rd')
