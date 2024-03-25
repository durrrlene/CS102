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
cformat_dates <- dmy(deets$Date)
posix_dates <- as.POSIXct(cformat_dates, format = "%m-%d-%Y", tz = "")

#removing the UTC and PST(timezone information)
formatted_dates <- format(posix_dates, "%m-%d-%Y")
formatted_dates

#removing the UTC and PST allows me to correct the format of the date to M-D-Y,
#while it still has I encounter problem converting those to new format.









