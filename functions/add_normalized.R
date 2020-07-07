add_normalized <- function(data, var){
df <- data %>%
    filter({{var}} == 1) %>%
    group_by({{var}}, date) %>%
    count() 

df$rescaled <- scales::rescale(df$n, to = c(0,1)) %>% round(2) * 100

df[,-1]
}