
add_US_location <- function(df){

    # US cities and states dictionary

    us_cities <- maps::us.cities$name %>% stringr::str_replace_all(" [[:alpha:]]*$", "") %>% unique() %>% tolower()

    us_states <- maps::us.cities$name %>% stringr::word(-1) %>% unique() %>% abbr2state() %>% tolower()

    us_country <- c("United States", "USA", "US", "U.S.A.") %>% tolower()

    us_location_list <- c(us_cities, us_states, us_country)

    # Other country dictionary

    countryname_dict <- unique(maps::world.cities$country.etc)

    countryname_dict <- countryname_dict[!countryname_dict %in% c("United States", "USA", "U.S.A.")]

    # Filter

    df[["US"]] <- str_detect(df[["location"]] %>% tolower(), us_location_list %>% paste(collapse = "|")) %>% as.numeric()

    df[["non_US"]] <- str_detect(df[["location"]] %>% tolower(), countryname_dict %>% tolower() %>% paste(collapse = "|")) %>% as.numeric()

    # Output

    df

}
