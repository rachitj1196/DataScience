library(datasets)
data(iris)

plot(iris)
plot(iris, col='red')

#Scatter Plot
plot(iris$Sepal.Width, iris$Sepal.Length, col='red', xlab='Sepal Width',
     ylab = 'Sepal Length')

#Hisrogram
hist(iris$Sepal.Width, col = 'red')

# Feature Plot

install.packages("caret")
library(caret)
?featurePlot()
featurePlot(
  x=iris[,1:4],
  y= iris$Species,
  plot='box',
  strip=strip.custom(par.strip.text=list(cex=0.7)),
  scales=list(x=list(relation='free'),
              y= list(relation='free')))


