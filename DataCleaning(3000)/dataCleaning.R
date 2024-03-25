library(dplyr)
library(tidyverse)

deets <- read.csv("C:/Users/steve/Documents/CS102/DataCleaning(3000)/3000MergedReviews.csv")


str(deets)
  
deets[,2:5]

deets[2:5, ]

#check for miss values
is.na(tail(deets))

#count missing values
sum(is.na(deets))


#change format of date





