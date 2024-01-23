library(xml2)
library(httr)
library(rvest)
library(purrr)
library(stringr)
library(dplyr)
library(polite)

session <- bow(url,
               user_agent = "Educational")
session



####################################### ART CATEGORY #####################################################

#ARTS 
HTML_arts <- read_html("https://www.amazon.com/s?i=specialty-aps&bbn=4954955011&rh=n%3A4954955011%2Cn%3A%212617942011%2Cn%3A2747968011&ref=nav_em__nav_desktop_sa_intl_painting_drawing_supplies_0_2_8_2")

# DESCRIPTION
HTML_arts %>%
  html_nodes('.s-line-clamp-4') %>%
  html_text() -> art_brand_desc

# PRICE
HTML_arts %>%
  html_nodes('.a-price') %>%
  html_text() -> art_price

# REVIEWS
HTML_arts %>%
  html_nodes('.a-size-base.s-underline-text') %>%
  html_text() -> art_reviews

# STARS
HTML_arts %>%
  html_nodes('.aok-align-bottom') %>%
  html_text() -> art_stars

cat("Length of brand description:", length(art_brand_desc), "\n")
cat("Length of price:", length(art_price), "\n")
cat("Length of reviews:", length(art_reviews), "\n")
cat("Number of stars:", length(art_stars), "\n")

# Find the minimum length among the vectors
min_length <- min(length(art_brand_desc), length(art_price), length(art_reviews))

art_Reviews <- data.frame(
  Description = art_brand_desc[1:min_length],
  Price = art_price[1:min_length],
  Reviews = art_reviews[1:min_length],
  Stars = art_stars[1:min_length],
  stringsAsFactors = FALSE
)

#DATA OF ART CATEGORY 
dim(art_Reviews)
View(art_Reviews)



################################### WOMEN'S FASHION CATEGORY  #####################################################



#FASHION
HTML_fashion <- read_html("https://www.amazon.com/s?i=specialty-aps&bbn=16225018011&rh=n%3A7141123011%2Cn%3A16225018011%2Cn%3A1040660&ref=nav_em__nav_desktop_sa_intl_clothing_0_2_12_2")


#DESCRIPTION
HTML_fashion %>%
  html_nodes('.s-line-clamp-4') %>%
  html_text() -> fash_brand_desc

#PRICE
HTML_fashion %>% 
  html_nodes('.a-price') %>%
  html_text() -> fash_price

#REVIEWS
HTML_fashion %>%
  html_nodes('.a-size-base.s-underline-text') %>%
  html_text() -> fash_reviews

# STARS
HTML_fashion %>%
  html_nodes('.aok-align-bottom') %>%
  html_text() -> fash_stars


cat("Length of brand description:", length(fash_brand_desc), "\n")
cat("Length of price:", length(fash_price), "\n")
cat("Length of reviews:", length(fash_reviews), "\n")
cat("Number of stars:", length(fash_stars), "\n")


fash_Reviews <- data.frame(
  Description = fash_brand_desc[1:min_length],
  Price = fash_price[1:min_length],
  Reviews = fash_reviews[1:min_length],
  Stars = fash_stars[1:min_length],
  stringsAsFactors = FALSE
)

#DATA OF WOMEN'S FASHION CATEGORY
dim(fash_Reviews)
View(fash_Reviews)



combined_Reviews <- rbind(art_Reviews, fash_Reviews)

dim(combined_Reviews)
View(combined_Reviews)


write.csv(combined_Reviews, file = "combined_reviews.csv", row.names = FALSE)

