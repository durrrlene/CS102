library(dplyr)
library(tidyverse)
library(lubridate)

orig <- read.csv("C:/Users/steve/Documents/CS102/DataCleaning(3000)/3000MergedReviews.csv")
deets <- read.csv("C:/Users/steve/Documents/CS102/DataCleaning(3000)/3000MergedReviews.csv")


str(deets)
  
deets[,2:5]

deets[2:5, ]

#----------------------------------- checking NA

#check for miss values
is.na(tail(deets))

#count missing values
sum(is.na(deets))



#----------------------------------- dates


#change format of date
cformat_dates <- dmy(deets$Date)
cformat_dates <- as.POSIXct(cformat_dates, format = "%b-%d-%Y", tz = "")

#making the month into its abbreviated name
cformat_dates_char <- format(cformat_dates, "%b-%d-%Y")


#removing the UTC and PST(timezone information)
deets$Date <- gsub("UTC|PST", "", cformat_dates_char)

View(deets)

#removing the UTC and PST allows me to correct the format of the date to M-D-Y,
#while it still has I encounter problem converting those to new format.


#----------------------------------- reviews


#checking unnecessary punctuation
unecessary <- "[[:punct:]&&[^.!?]]" 

detectUn <- str_detect(deets$Content, unecessary)
detectUn

deets$Content


#cleaning reviews
deets$Content <- str_replace_all(deets$Content, "[[:punct:]]", "")
deets$Content <- str_replace_all(deets$Content, "\\d+", "")
deets$Content <- str_replace_all(deets$Content, "\\s+", " ")


#clean the reviews to lower cases
deets$Usernames <- tolower(deets$Usernames)
deets$Content <- tolower(deets$Content)

View(deets)
View(orig)


#----------------------------------- ratings

#extracting numerator and denominator
rating_parts <- strsplit(deets$Rating, "/")

#converting to numeric
numerators <- sapply(rating_parts, function(x) as.numeric(x[1]))
denominators <- sapply(rating_parts, function(x) as.numeric(x[2]))

#calculate
numeric_rating <- numerators / denominators

#overriding the original ratings 
deets$Rating <- numeric_rating



