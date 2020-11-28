library(datasets)
library(caret)

data("dhfr")

sum(is.na(dhfr))

set.seed(100)

# Splitting data into train and test model
TrainingIndex<- createDataPartition(dhfr$Y,p=0.8,list = FALSE)
Train<- dhfr[TrainingIndex,]
Test<- dhfr[-TrainingIndex,]

# Using Random Forest
install.packages("randomForest")
install.packages("e1071")
library(randomForest)
library(e1071)
# Run Normally without parallel processing
start.time<- proc.time()
Model<-train(Y~., data=Train, method="rf", tuneGrid=data.frame(mtry=seq(5,15, by=5))
             )
stop.time<- proc.time()
run.time<- stop.time - start.time
print(run.time)

# Time taken is 57.51 seconds

# To speed up our calculation, we use Parallel Computing
install.packages("doParallel")
library(doParallel)

cl<- makePSOCKcluster(5)
registerDoParallel(cl)

start.time<- proc.time()
Model<- train(Y~., data= Train, method="rf", tuneGrid=data.frame(mtry=seq(5,15, by=5)))
stop.time<-proc.time()
run.time<- stop.time - start.time
print(run.time)
stopCluster(cl)

# Time taken is 17.7 seconds
# Parallel processing is 3.24 times faster (57.51/17.7)

# Apply model for prediction
Model.Train<- predict(Model, Train)

# Confusion Matrix
Model.train.confusionmatrix<- confusionMatrix(Model.Train, Train$Y)
print(Model.train.confusionmatrix)

# Feature Importance
Importance<-varImp(Model)
plot(Importance, top=10)
plot(Importance, col="red")

