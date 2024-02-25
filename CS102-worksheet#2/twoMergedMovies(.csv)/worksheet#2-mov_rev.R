library(xml2)
library(httr)
library(rvest)
library(purrr)
library(stringr)
library(dplyr)
library(polite)

polite::use_manners(save_as = 'polite_scrape.R')

#FIRST MOVIE URL('FLIPPED')
url <- 'https://www.imdb.com/title/tt0817177/reviews/ajax?ref_=undefined&paginationKey=%s'

session <- bow(url,
               user_agent = "Educational")
session



scrape_reviews <- function(url) {
  HTML_movie <- read_html(url)
  
  # USERNAME
  HTML_movie %>%
    html_nodes('.display-name-link') %>%
    html_text() -> username
  
  # TITLE
  HTML_movie %>%
    html_nodes('.title') %>%
    html_text() -> title
  
  # CONTENT OF REVIEW
  HTML_movie %>%
    html_nodes('.content') %>%
    html_text() -> content
  
  # STARS
  HTML_movie %>%
    html_nodes('.rating-other-user-rating') %>%
    html_text() -> stars
  
  # DATE
  HTML_movie %>%
    html_nodes('.review-date') %>%
    html_text() -> date
  
  min_length_rev <- min(length(username), length(title), length(content), length(stars), length(date))
  
  all_rev <- data.frame(
    Username = username[1:min_length_rev],
    Title = title[1:min_length_rev],
    Content = content[1:min_length_rev],
    Stars = stars[1:min_length_rev],
    Date = date[1:min_length_rev],
    stringsAsFactors = FALSE
  )
  
  return(all_rev)
}

base_url <- 'https://www.imdb.com/title/tt0817177/reviews'

target_reviews <- 300

FLIPPED <- data.frame()



page <- 1
while (nrow(FLIPPED) < target_reviews) {
  url <- paste0(base_url, page)
  reviews_on_page <- scrape_reviews(url)
  FLIPPED <- bind_rows(FLIPPED, reviews_on_page)
  page <- page + 1
}

FLIPPED <- FLIPPED[1:target_reviews, ]


cat("Number of scraped reviews: ", nrow(FLIPPED), "\n")
View(FLIPPED)


########################## Metascore ########################

metascore_url <- 'https://www.imdb.com/title/tt0817177/?ref_=nv_sr_srsg_0_tt_8_nm_0_q_flipped'
HTML_score <- read_html(metascore_url)
metascore <- HTML_score %>%
  html_nodes('.score') %>%
  html_text() %>%
  as.numeric()

# Create a data frame for Metascore
metascore_df <- data.frame(Metascore = metascore)

# Combine the Metascore data frame with the reviews data frame
combined_data <- bind_rows(metascore_df, all_reviews)

# Display the combined data
View(combined_data)




#SECOND MOVIE URL('TOY STORY')


url2 <- 'https://www.imdb.com/title/tt0114709/reviews?ref_=tt_urv'


scrape_reviews2 <- function(url) {
  HTML_movie2 <- read_html(url)
  
  #USERNAME
  HTML_movie2 %>%
    html_nodes('.display-name-link') %>%
    html_text() -> movie2_username
  
  # TITLE
  HTML_movie2 %>%
    html_nodes('.title') %>%
    html_text() -> movie2_title
  
  # CONTENT OF REVIEW
  HTML_movie2 %>%
    html_nodes('.content') %>%
    html_text() -> movie2_content
  
  # STARS
  HTML_movie2 %>%
    html_nodes('.rating-other-user-rating') %>%
    html_text() -> movie2_stars
  
  # DATE
  HTML_movie2 %>%
    html_nodes('.review-date') %>%
    html_text() -> movie2_date
  
  
  movie2_min_length_rev <- min(length(movie2_username), length(movie2_title), length(movie2_content), length(movie2_stars), length(movie2_date))
  
  TOYS_STORY <- data.frame(
    Username = movie2_username[1:min_length_rev],
    Title = movie2_title[1:min_length_rev],
    Content = movie2_content[1:min_length_rev],
    Stars = movie2_stars[1:min_length_rev],
    Date = movie2_date[1:min_length_rev],
    stringsAsFactors = FALSE
  )
  
  return(TOYS_STORY)
}


movie2_base_url <- 'https://www.imdb.com/title/tt0114709/reviews?ref_=tt_urv'

movie2_target_reviews <- 300

TOYS_STORY <- data.frame()

movie2_page <- 1
while (nrow(TOYS_STORY) < movie2_target_reviews) {
  url2 <- paste0(movie2_base_url, movie2_page)
  movie2_reviews_on_page <- scrape_reviews(url2)
  TOYS_STORY <- bind_rows(TOYS_STORY, movie2_reviews_on_page)
  movie2_page <- movie2_page + 1
}

TOYS_STORY <- movie2_all_reviews[1:movie2_target_reviews,]

cat("Number of scraped reviews: ", nrow(movie2_all_reviews), "\n")
View(TOYS_STORY)





#THIRD MOVIE URL
url3 <- 'https://www.imdb.com/title/tt1049413/reviews?ref_=tt_urv'

scrape_reviews3 <- function(url) {
  HTML_movie3 <- read_html(url)
  
  #USERNAME
  HTML_movie3 %>%
    html_nodes('.display-name-link') %>%
    html_text() -> movie3_username
  
  # TITLE
  HTML_movie3 %>%
    html_nodes('.title') %>%
    html_text() -> movie3_title
  
  # CONTENT OF REVIEW
  HTML_movie3 %>%
    html_nodes('.content') %>%
    html_text() -> movie3_content
  
  # STARS
  HTML_movie3 %>%
    html_nodes('.rating-other-user-rating') %>%
    html_text() -> movie3_stars
  
  # DATE
  HTML_movie3 %>%
    html_nodes('.review-date') %>%
    html_text() -> movie3_date































