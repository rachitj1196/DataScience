library(datasets)
library(caret)
data("dhfr")
View(dhfr)
head(dhfr,5)

library(skimr)
skim(dhfr)

skim(dhfr$Y)

# Group data by Y (Biological Activity), then perform skim
dhfr %>% 
  dplyr::group_by(Y) %>% 
  skim()

# Scatter Plot
plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col='blue')

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col= dhfr$Y)

# Creating model
set.seed(100)

# Data Splitting
TrainingIndex<- createDataPartition(dhfr$Y, p=0.8, list=FALSE)
TrainingSet<- dhfr[TrainingIndex,]
TestingSet<- dhfr[-TrainingIndex,]


# Build Training Model (SVM Polynomial Kernel)
model<- train(Y~. , data=TrainingSet, method='svmPoly')


# Save Model to RDS file
saveRDS(model, "Model.rds")

# Read model from rds file
read.model<- readRDS("Model.rds")


# Apply model for prediction
model.training<-predict(read.model, TrainingSet)
model.testing<-predict(read.model, TestingSet)

# Confusion Matrix
model.training.confmat<- confusionMatrix(model.training, TrainingSet$Y)
model.training.confmat

model.testing.confmat<- confusionMatrix(model.testing, TestingSet$Y)
model.testing.confmat


# Feature Importance
Importance<- varImp(read.model)
plot(Importance,top=5,col='red')





