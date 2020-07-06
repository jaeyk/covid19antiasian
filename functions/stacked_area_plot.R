
stacked_area_plot <- function(df, var){
    
  df %>%
    mutate(var = recode({{var}}, 
                        '1' = 'Yes',
                        '0' = 'No')) %>%
    group_by(date, var) %>%
    dplyr::summarize(n = n()) %>%
    mutate(prop = n / sum(n),
           prop = round(prop,2)) %>%
    ggplot(aes(x = as.Date(date), y = prop,
               fill = factor(var))) +
    geom_area() +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    theme_pubr() +
    scale_fill_npg() 
  
}