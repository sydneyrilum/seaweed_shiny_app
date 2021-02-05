# This is our seaweed shiny app!

library(tidyverse)
library(shiny)

# Define UI for application
ui <- fluidPage(

  navbarPage("TITLE!",
             tabPanel("Tab 1",
                      sidebarLayout(
                          sidebarPanel("WIDGETS!",
                                       selectInput(inputId = "pick species",
                                       label = h3("seaweed type"),
                                       choices = list(
                                       "seaweed 1" = 1, "seaweed 2" = 2, "seaweed 3" = 3),
                                       selected = 1)
                                       ),
                          mainPanel("OUTPUT"))
                      ),
             tabPanel("Tab 2"),
             tabPanel("Tab 3")

  )

)

server <- function(input, output) {




}

# Run the application
shinyApp(ui = ui, server = server)




