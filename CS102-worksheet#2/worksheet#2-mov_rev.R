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

base_url <- 'https://www.imdb.com/title/tt0817177/reviews?ref_=tt_urv&page='

target_reviews <- 300

all_reviews <- data.frame()



page <- 1
while (nrow(all_reviews) < target_reviews) {
  url <- paste0(base_url, page)
  reviews_on_page <- scrape_reviews(url)
  all_reviews <- bind_rows(all_reviews, reviews_on_page)
  page <- page + 1
}

all_reviews <- all_reviews[1:target_reviews, ]


cat("Number of scraped reviews: ", nrow(all_reviews), "\n")
View(all_reviews)





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


