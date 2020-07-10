# load package 
library(tidyverse)
library(stringr)
library(here)

# load data 
US_tweets <- read.csv(here("processed_data", "US_tweets.csv"))

# Extract hashtags 
US_tweets$hashtags <- str_extract(US_tweets$full_text, "#\\S+") 

US_tweets$stop_hashs <- str_detect(US_tweets$hashtags, "covid|corona")

US_tweets <- US_tweets %>% filter(stop_hashs == 0)

US_tweets %>% count(hashtags, sort = TRUE)