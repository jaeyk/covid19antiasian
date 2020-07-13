
# Devtools library 

# Import libraries 
pacman::p_load(tidyverse, # Tidyverse
               gtrendsR, # Interface for retrieving data from the Google Search API
               here) # Reproducibility 
 
search_gtrends <- function(terms){

    # Search 
        trends <- gtrends(keyword = terms, 
                          geo = 'US', 
                          # match to the twitter data
                          time = "2020-01-09 2020-06-21",
                          low_search_volume = TRUE)
    
    # Transform list into a tibble 
        results <- tibble(date = lubridate::ymd(trends$interest_over_time$date),
                          hits = as.numeric(as.character(trends$interest_over_time$hits)),
                          keywords = trends$interest_over_time$keyword)

}
 
## Search and bind 

gtrends <- bind_rows(search_gtrends("'Racism' + 'Antiasian' + 'Racist' + 'hate crime'"),
                    search_gtrends("'Chinese flu' + 'Chinese virus'"),
                    search_gtrends("Wuhan virus"),
                    search_gtrends("Kung Flu")) %>%
           mutate(date = lubridate::ymd(date))

## Export
write_csv(gtrends, here("processed_data", "gtrends.csv"))