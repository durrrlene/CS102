library(rvest)
library(httr)
library(dplyr) # use of pipeline %>%
library(polite)
library(kableExtra)

polite::use_manners(save_as = 'polite_scrape.R')

url <- "https://www.amazon.com/s?i=specialty-aps&bbn=4954955011&rh=n%3A4954955011%2Cn%3A%212617942011%2Cn%3A2747968011&ref=nav_em__nav_desktop_sa_intl_painting_drawing_supplies_0_2_8_2"

session <- bow(url,
               user_agent = "Educational")
session

session_page <- scrape(session)

div_elements <- html_nodes(session_page, '.sg-col-20-of-24.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16')

links <- character()
img_srcs <- character()
brand_name <- character()
description <- character()
prices <- character()
num_reviews <- character()
stars <- character()

for (div_element in div_elements) {
  
  a_element <- html_node(div_element, 'a.a-link-normal.s-no-outline')
  link <- ifelse(!is.na(a_element), paste0("https://amazon.com", html_attr(a_element, "href")), '')
  
  #IMAGE
  img_element <- html_node(div_element, '.s-product-image')
  img_src <- ifelse(!is.na(img_element), html_attr(img_element, "src"), '') 
  
  
  
  #BRANDS
  brand_el <- html_nodes(div_element, '.a-size-base-plus.a-color-base') %>% 
    html_text()
  brand <- ifelse(!is.na(brand_el), brand_el, '')
  
  # DESCRIPTION
  desc_el <- html_nodes(div_element, '.a-size-base-plus.a-color-base.a-text-normal') %>% 
    html_text()
  description <- ifelse(!is.na(desc_el), desc_el, '')
  
  # PRICE
  price_el <- html_nodes(div_element, '.a-price-whole') %>% 
    html_text()
  price <- ifelse(!is.na(price_el), price_el, '')
  
  # REVIEWS
  reviews_el <- html_nodes(div_element, '.a-size-base.s-underline-text') %>% 
    html_text()
  reviews <- ifelse(!is.na(reviews_el), reviews_el, '')
  
  # STARS
  stars_el <- html_nodes(div_element, '.a-declarative') %>% 
    html_text()
  stars <- ifelse(!is.na(stars_el), stars_el, '')
  
  links <- c(links, link)
  img_srcs <- c(img_srcs, img_src)
  brand_name <- c(brand_name, brand)
  description <- c(description, description)
  prices <- c(prices, price)
  num_reviews <- c(num_reviews, reviews)
  stars <- c(stars, stars)
  
}

product_df <- data.frame(
  Link = links,
  Image_Src = img_srcs,
  Brand = brand_name,
  Description = description,
  Price = prices, 
  Reviews = num_reviews,
  Stars = stars)

write.csv(product_df, "product.csv", row.names = FALSE)
