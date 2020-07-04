
# Import packages 

pacman::p_load(data.table, # for fast data manipulation
               jsonlite, # for importing json data
               tidyverse, # for tidyverse
               here, # for reproducibility
               tidyjson, # for json data manipulation
               purrr, # for functional programming
               tictoc) # for performance test 

library(tidytweetjson)

# Parse all 

future::plan("multiprocess")

tictoc::tic()
df <- jsonl_to_df_all(dir_path = "/home/jae/hateasiancovid/processed_data/splitted_data")
tictoc::toc()

# Save it. Note that `Compress = FALSE` makes saving fast 

saveRDS(df, "/home/jae/hateasiancovid/processed_data/parsed.rds", 
        compress = FALSE)
