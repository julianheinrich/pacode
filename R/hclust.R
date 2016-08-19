# playground
rm(list=ls())
library(dplyr)

cars <- sample_n(mtcars, 5)
dm <- dist(cars)
hc <- hclust(dm)
dend <- as.dendrogram(hc)
plot(dend, type="triangle")
