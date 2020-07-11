# Load packages 
pacman::p_load(keyATM, 
               here, 
               tidyverse,
               quanteda,
               ggsci, 
               ggthemes, 
               ggpubr,
               latex2exp)

theme_set(theme_pubr())

# Load files 
keyATM_docs <- read_rds(here("processed_data", "keyATM_docs.rds"))

my_corpus <- read_rds(here("outputs", "my_corpus.rds"))

# Keywords 
keywords <- list("Anti-Asian" = c("wuhanvirus", "chinesevirus", "chinavirus", "wuhancoronavirus", "wuhanpneumonia", "ccpvirus", "chinaliedpeopledied"))

# Run dynamic topic model 
future::plan("multiprocess")

tictoc::tic()
dynamic_out_day <- keyATM(docs = keyATM_docs,    # text input
                      no_keyword_topics = 2,              # number of topics without keywords
                      keywords = keywords,       # keywords
                      model = "dynamic",         # select the model
                      model_settings = list(time_index = docvars(my_corpus)$index,                                          num_states = 5),
                      options = list(seed = 250, store_theta = TRUE, thinning = 5))
tictoc::toc()

# Save 
write_rds(dynamic_out_day, here("outputs", "dynamic_out_day.rds"))

# dynamic_out_day <- read_rds(here("outputs", "dynamic_out_day.rds"))

# Visualize 
fig_timetrend_day <- plot_timetrend(dynamic_out_day, time_index_label = as.Date(docvars(my_corpus)$date), xlab = "Date", width = 5) 

keyATM::save_fig(fig_timetrend_day, here("outputs", "dynamic_topic_day.png"))

# Alt visualize 

df <- data.frame(date = fig_timetrend_day$values$time_index,
                mean = fig_timetrend_day$values$Point,
                upper = fig_timetrend_day$values$Upper,
                lower = fig_timetrend_day$values$Lower)

df %>% ggplot() +
    geom_line(aes(x = date, y = mean),
              alpha = 0.9, size = 1.5) +
    geom_ribbon(aes(x = date, y = mean, ymax = upper, ymin = lower),
                alpha = 0.3) +
    geom_smooth(aes(x = date, y = mean, ymax = upper, ymin = lower),
                method = "loess", size = 1.5) +
    labs(title = "The time trend of Anti-Asian topic",
         subtitle = "Tweets mentioned COVID-19 and either Asian, Chinese, or Wuhan",
         x = "Date", 
         y = TeX(paste("Mean of", "$\\theta$", sep = " "))) +
    geom_vline(xintercept = as.Date(c("2020-03-16")), 
               linetype = "dashed", size = 1.5)

ggsave(here("outputs", "anti_asian_topic_dynamic_trend.png"))
    
