library(xml2)
library(httr)
library(rvest)
library(purrr)
library(stringr)
library(dplyr)
library(polite)

url <- 'https://www.imdb.com/title/tt0817177/reviews?ref_=tt_urv'

session <- bow(url,
               user_agent = "Educational")
session



###########################################################################25###########################################################################################################################



HTML_movie <- read_html("https://www.imdb.com/title/tt0817177/reviews?ref_=tt_urv")


#USERNAME
HTML_movie %>%
  html_nodes('.display-name-link') %>%
  html_text() -> username


#TITLE

HTML_movie %>%
  html_nodes('.title') %>%
  html_text() -> title



#CONTENT OF REVIEW

HTML_movie %>%
  html_nodes('.content') %>%
  html_text() -> content


#STARS

HTML_movie %>%
  html_nodes('.rating-other-user-rating') %>%
  html_text() -> stars



#DATE

HTML_movie %>%
  html_nodes('.review-date') %>%
  html_text() -> date


#METASCORE


#CATTTTTT
cat("Username: ", length(username), "\n")
cat("Title: ", length(title), "\n")
cat("Content: ", length(content), "\n")
cat("Stars: ", length(stars), "\n")
cat("Date: ", length(date), "\n")


min_length_rev <- min(length(username), length(title), length(content), length(stars), length(date))



all_rev <- data.frame(
  Username = username[1:min_length_rev],
  Title = title[1:min_length_rev],
  Content = content[1:min_length_rev],
  Stars = stars[1:min_length_rev],
  Date = date[1:min_length_rev],
  stringsAsFactors = FALSE
)


dim(all_rev)
View(all_rev)


###########################################################################25###########################################################################################################################







