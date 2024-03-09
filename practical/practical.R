library(readr)
library(readxl)

warpbreaks

##is.numeric(warpbreaks)
#A.2. No, cause if any column that decimal, that column will
#   be an integer


#A.3 It show that the dataframe contains a list instead of
#    numeric value 



as.integer(warpbreaks)

strtoi(warpbreaks)




#////////////////////////////////\


file_path <- "exampleFile.txt"

readLines(file_path)


#data <- read.csv(file_path, header = FALSE,
 #                col.names = c("Gender", "Age", "Weight"), 
  #               stringsAsFactors = FALSE)
#data$Age <- as.numeric(data$Age)


data <- c("//Survey data. Created : 21 May 2013",
          "//Field 1: Gender",
          "//Field 2: Age (in years)",
          "//Field 3: Weight (in kg)",
          "M;28;81.3",
          "male;45;",
          "Female;17;57,2",
          "fem.;64;62.8")
data_in <- grepl("Gender|Age|Weight", data)

data <- data[-which(data == "//Survey data. Created : 21 May 2013")]

#B.4.a Split the character vectors in the vector containing data lines by semicolon (;)
# using strsplit.
#splitting of data
split_data <- strsplit(data, ";")
fields <- max(lengths(split_data))

#B.4.b
split_data <- lapply(split_data, function(x) c(x, rep(NA, fields - length(x))))


#B.4.c
split_data <- matrix(unlist(split_data), ncol = fields, byrow = TRUE)

data_lines <- data[data_in]

print(data_lines)












