library(dplyr)
library(tidyverse)
library(lubridate)

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
cformat_dates <- as.POSIXct(cformat_dates, format = "%b-%d-%Y", tz = "")

#making the month into its abbreviated name
cformat_dates_char <- format(cformat_dates, "%b-%d-%Y")


#removing the UTC and PST(timezone information)
formatted_dates <- gsub("UTC|PST", "", cformat_dates_char)

formatted_dates

#removing the UTC and PST allows me to correct the format of the date to M-D-Y,
#while it still has I encounter problem converting those to new format.



#clean the reviews to lower cases







