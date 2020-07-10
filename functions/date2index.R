# Time index  

date2index <- function(df){
  
# Convert date into integer 

index <- as.integer(gsub("-", "", docvars(df)$date))

# Replace elements in the numeric vector with the new list of the character vector 

char_index <- as.character(index)

# Condition 
given <- sort(unique(index)) %>% as.character()

# For loop 
for (i in seq(1:length(unique(index)))){
  
  char_index[char_index == given[i]] = paste(i)
  
  message(paste("replaced", i))
  
}

# Check 
# unique(char_index) %>% as.numeric() %>% sort()

docvars(df, "index") <- char_index %>% as.integer()

docvars(df) <- docvars(df) %>%
  arrange(index)

docvars(df)
}