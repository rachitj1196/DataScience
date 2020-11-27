library(caret)
# Importing data set
data(iris)
# checking for any missing values
sum(is.na(iris))
# To achieve reproducible model, set random seed number
set.seed(100)

# Splitting data into test and training data sets
train_index<- createDataPartition(iris$Species, p=0.8, list = FALSE)
train_set<- iris[train_index,]
test_set<-iris[-train_index,]

# SVM MODEL

model<-train(Species~., data = train_set,
             method='svmPoly',
             na.action = na.omit,
             preProcess=c('scale','center'),
             trControl= trainControl(method = 'cv', number = 10),
             tuneGrid=data.frame(degree=1, scale=1,C=1))


# Build a CV model
model.cv<-train(Species~., data = train_set,
                method='svmPoly',
                na.action = na.omit,
                preProcess=c('scale','center'),
                trControl= trainControl(method = 'cv', number = 10),
                tuneGrid=data.frame(degree=1, scale=1,C=1))

# Apply model for prediction
train_model<-predict(model,data=train_set)
test_model<- predict(model,data= test_set)
model.cv<-predict(model.cv, train_set)

# Model Performance (Confusion Matrix)
train_model_confmat<-confusionMatrix(train_model,train_set$Species)
test_model_confmat<-confusionMatrix(test_model,test_set$Species)
model.cv_confmat<- confusionMatrix(model.cv, train_set$Species)

print(train_model_confmat)
print(test_model_confmat)
print(model.cv_confmat)
