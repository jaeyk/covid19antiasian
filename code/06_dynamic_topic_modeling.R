# Load packages 
pacman::p_load(keyATM, 
               here, 
               tidyverse,
               quanteda)

# Load files 
keyATM_docs <- read_rds(here("processed_data", "keyATM_docs.rds"))

my_corpus <- read_rds(here("outputs", "my_corpus.rds"))

# Keywords 
keywords <- list("Anti-Asian" = c("wuhanvirus", "chinesevirus", "chinavirus", "wuhancoronavirus", "wuhanpneumonia"))

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

#dynamic_out_day <- read_rds(here("outputs", "dynamic_out_day.rds"))

# Visualize 
fig_timetrend_day <- plot_timetrend(dynamic_out_day, time_index_label = as.Date(docvars(my_corpus)$date), xlab = "Date", width = 5) 

# Export 

fig_timetrend_day

keyATM::save_fig(fig_timetrend_day, here("outputs", "dynamic_topic_day.png"))
