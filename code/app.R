
# load package 
pacman::p_load(
    tidyverse, # tidyverse 
    wordcloud2, # Interactive wordcloud
    shiny, # for Shiny
    shinydashboard, # for Shiny dashboard
    colourpicker) # for better visual 

# load data 

df <- read.csv(here("processed_data", "hash_counts.csv"))[,-1]

body <- fluidPage(
  
    h1("Word Cloud on the Hashtags of the Tweets related to COVID-19 & Asian|Chinese|Wuhan"),
  
    h4(tags$a(href = "https://jaeyk.github.io/", "Developer: Jae Yeon Kim")),
            
    mainPanel(
          
          wordcloud2Output("cloud"),
        
        )
    
    )
  
server <- function(input, output) {
  
  output$cloud <- renderWordcloud2({ 
    
    wordcloud2(df, 
               size = 2.5, 
               color = "random-dark") 
    
    })

  }

shinyApp(ui = ui, server = server)