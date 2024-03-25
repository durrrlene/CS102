library(dplyr)
library(tidyverse)
library(lubridate)


#loading data
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

head(deets)

tail(deets)


#removing the UTC and PST allows me to correct the format of the date to M-D-Y,
#while it still has I encounter problem converting those to new format.


#----------------------------------- reviews


#checking unnecessary punctuation
unecessary <- "[[:punct:]&&[^.!?]]" 

detectUn <- str_detect(deets$Content, unecessary)
(head(detectUn, 50))


#cleaning reviews
deets$Content <- gsub("[[:punct:]]", "", deets$Content)
deets$Content <- gsub("\\d+", "", deets$Content)
deets$Content <- gsub("\\s+", " ", deets$Content)


#clean the reviews to lower cases
deets$Usernames <- tolower(deets$Usernames)
deets$Content <- tolower(deets$Content)



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



#----------------------------------- getting the average

average_value <- mean(deets$Rating, na.rm = TRUE)
print(average_value)

#round off average to 1 decimal point
rounded_avg <- round(average_value, digits = 1)
print(rounded_avg)


#----------------------------------- filling the NA Ratings with average

deets <- replace_na(deets, list(Rating = rounded_avg))


#----------------------------------- checking if there's still NAs

(na_check <- any(is.na(deets)))
(na_check <- any(is.na(deets$Movie_name)))
(na_check <- any(is.na(deets$Usernames)))
(na_check <- any(is.na(deets$Date)))
(na_check <- any(is.na(deets$Content)))
(na_check <- any(is.na(deets$Rating)))

#I just detected that there's still null values on Usernames, Date, and Content.
#I cannot just add anything on it, since Ma'am Jamile instructed us not to remove
#those with NAs, and just fill none other than the Rating's column.

