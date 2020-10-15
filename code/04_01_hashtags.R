
# load package 
pacman::p_load(
    tidyverse, # tidyverse 
    stringr, # for string manipulation
    here, # for reproducibility
    wordcloud, # Static wordcloud
    wordcloud2, # Interactive wordcloud
    webshot, # Save jave script wordcloud
    htmlwidgets) # Save jave script wordcloud

# load data 
US_tweets <- read.csv(here("processed_data", "US_tweets.csv"))

# Extract hashtags 
US_tweets$hashtags <- str_extract(US_tweets$full_text, "#\\S+") 

# Remove too common hashtags (I defined them as stop_hashs)
US_tweets$stop_hashs <- str_detect(US_tweets$hashtags, "covid|corona")

US_tweets <- US_tweets %>% 
    filter(stop_hashs == 0) %>% 
    filter(wuhan == 1 | asian == 1 | chinese == 1)
                                  
# Count 
hash_counts <- US_tweets %>%
    mutate(hashtags = str_replace(hashtags, "#", "")) %>%
    mutate(hashtags = tm::removePunctuation(hashtags)) %>%
    count(hashtags, sort = TRUE) %>%
    filter(hashtags != "china" & hashtags != "wuhan" )

# Export data 
write.csv(hash_counts, here("processed_data", "hash_counts.csv"))

# Produce word cloud
hash_cloud <- wordcloud2(hash_counts, size = 2.5, 
                         color = "random-dark")

hash_cloud

# Save in HTML
htmlwidgets::saveWidget(hash_cloud, here("outputs", "hash_cloud.html"), selfcontained = FALSE)

# Save in PNG
webshot(here("outputs", "hash_cloud.html"), 
        here("outputs", "hash_cloud.png"), 
        delay =5, 
        vwidth = 600, 
        vheight= 600)
