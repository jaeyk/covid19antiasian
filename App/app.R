
# load package 

require("wordcloud2")
require("shiny")
require("shinydashboard")
require("colourpicker")

# load data 

df <- read.csv(url("https://github.com/jaeyk/covid19antiasian/raw/master/processed_data/hash_counts.csv"))[,-1]

ui <- fluidPage(
  
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
