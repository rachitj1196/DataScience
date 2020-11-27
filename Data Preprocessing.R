library(datasets)
library(caret)
data("dhfr")
View(dhfr)
# Check for any null or "na" Values
sum(is.na(dhfr))

# If data is clean, randomly introduce NA to the dataset

na.gen<-function(data,n){
  i<-1
  while(i<n+1){
    idx1<-sample(1:nrow(data),1)
    idx2<-sample(1:ncol(data),1)
    data[idx1,idx2]<-NA
    i=i+1
  }
  return(data)
}

# Adding NA into dataset
dhfr<-dhfr[,-1]
dhfr<-na.gen(dhfr,100)

# check again for missing data
sum(is.na(dhfr))

colSums(is.na(dhfr))

str(dhfr)
library(skimr)
skim(dhfr)

# List rows with missing data
missingdata<- dhfr[!complete.cases(dhfr),]
sum(is.na(missingdata))

# Data Imputation

dhfr_impute<- dhfr

for(i in which(sapply(dhfr_impute, is.numeric))){
  dhfr_impute[is.na(dhfr_impute[,i]), i]<- mean(dhfr_impute[,i], na.rm = TRUE)
}

sum(is.na(dhfr_impute))


