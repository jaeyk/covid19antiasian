
# The following code heavily draws on this blog post: https://www.statsandr.com/blog/draw-a-word-cloud-with-a-shiny-app/

# load package 
pacman::p_load(
    tidyverse, # tidyverse 
    wordcloud2, # Interactive wordcloud
    shiny, # for Shiny
    shinydashboard, # for Shiny dashboard
    colourpicker) # for better visual 

# load data 

df <- read.csv(here("processed_data", "hash_counts.csv"))

body <- dashboardBody(
  fluidRow(
    box(
      plotOutput("barplot"),
      wordcloud2Output("wordcloud")
    )
  )
)

server <- function(input, output) {
  output$wordcloud <- renderWordcloud2({ wordcloud2(data) })
  output$barplot <- renderPlot({ barplot(df$n, names.arg = df$hashtags) })
}

shinyApp(dashboardPage(dashboardHeader(), dashboardSidebar(), body), server)