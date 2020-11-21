library(datasets)
# Importing dataset
data("iris")
iris<-datasets::iris
View(iris)

# Summary Stats
head(iris,5)
tail(iris)

summary(iris)
str(iris)
summary(iris$Sepal.Length)

# Checking if there is any null values
sum(is.na(iris))

# skimr()- expands on summary() by providing larger set of stats
install.packages("skimr")
library(skimr)
skim(iris)

# Group data by species and then performing skim
iris %>% 
  dplyr::group_by(Species) %>% 
  skim()


# Quick Data Visualization
plot(iris)
plot(iris, col='red')

plot(iris$Sepal.Length, iris$Sepal.Width, col= 'blue')



