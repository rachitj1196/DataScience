install.packages("mlbench")
library(mlbench)
library(caret)

#Importing Data
data("BostonHousing")
head(BostonHousing)

# Check for any missing data
sum(is.na(BostonHousing))

#Splitting data into train and test data sets
set.seed(100)
TrainingIndex<- createDataPartition(BostonHousing$medv, p=0.8,
                                    list=FALSE)
Train<- BostonHousing[TrainingIndex,]
Test<- BostonHousing[-TrainingIndex,]

# Build Training Model
Model<- train(medv~., data = Train, method='lm',
              na.action = na.omit,
              preProcess=c('scale','center'),
              trControl= trainControl(method='none'))


#Apply Model for prediction
Model.Train<- predict(Model, Train)
Model.Test<- predict(Model, Test)

# Performance Metrics

plot(Train$medv, Model.Train, col='blue')
plot(Test$medv, Model.Test, col='red')

summary(Model)


# Correlation Coefficient
Corr_Train<- cor(Train$medv, Model.Train)
Corr_Test<- cor(Test$medv, Model.Test)
