# This is our seaweed shiny app!

library(tidyverse)
library(shiny)

# Define UI for application
ui <- fluidPage(

  navbarPage("TITLE!",
             tabPanel("Tab 1"),
             tabPanel("Tab 2"),
             tabPanel("Tab 3")

  )

)

server <- function(input, output) {




}

# Run the application
shinyApp(ui = ui, server = server)




