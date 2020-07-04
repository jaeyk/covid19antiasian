
stacked_area_plot() <- function(df, var){
    
df %>%
    mutate(var = recode({{var}}, 
                          '1' = 'Yes',
                          '0' = 'No')) %>%
    group_by(date, var) %>%
    count() %>%
    ggplot(aes(x = as.Date(date), y = n,
               col = factor(var))) +
    geom_line() +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    theme_pubr() +
    scale_fill_npg() 
    
    }