
# load package 

require("wordcloud2")
require("vroom")
require("shiny")
require("shinydashboard")
require("colourpicker")

# load data 

df <- vroom::vroom(url("https://github.com/jaeyk/covid19antiasian/raw/master/processed_data/hash_counts.csv"))[,-1]

ui <- fluidPage(
  
    # Application title 
    titlePanel("Word Cloud on the Hashtags of the Tweets related to COVID-19 & Asian|Chinese|Wuhan"),
  
    h4(tags$a(href = "https://jaeyk.github.io/", "Developer: Jae Yeon Kim")),
            
    sidebarLayout(
      
      # Sidebar with sliders 
      sidebarPanel(
        sliderInput("size", 
                    "Font size:",
                    min = 1, max = 10,
                    value = 2)
      ),
    
    mainPanel(
          
          wordcloud2Output("cloud"),
        
        )
    
    )
)
  
server <- function(input, output, session) {
  
  output$cloud <- renderWordcloud2({ 
    
    wordcloud2(df, 
               size = input$size, 
               color = "random-dark") 
    
    })

  }

shinyApp(ui = ui, server = server)

