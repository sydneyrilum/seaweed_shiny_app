# This is our seaweed shiny app!

library(tidyverse)
library(shiny)
library(shinythemes)

# Create the user interface:
ui <- fluidPage(theme = shinytheme("cerulean"),

  navbarPage("Seaweed Suitability in the Gulf of Mexico",
             tabPanel("About",
                      sidebarLayout(
                        sidebarPanel( # maybe add photo of seaweed aquaculture here

                        ),
                        mainPanel(
                                   h1("About our app"),
                                   p("seaweed....."),
                                   br(),
                                   h3("Citations"),
                                   p("list citations here")
                        ))
                      ),

             tabPanel("Tab 1",
                      sidebarLayout(
                          sidebarPanel("WIDGET 1",
                                       selectInput(inputId = "pick_species",
                                       label = h3("Seaweed Species"),
                                       choices = list(
                                       "Seaweed 1" = 1, "Seaweed 2" = 2, "Seaweed 3" = 3),
                                       selected = 1),
                                       ),
                          mainPanel(
                                    uiOutput("img")
                                    ))
                      ),
             tabPanel("Tab 2",
                      sidebarLayout(
                          sidebarPanel("WIDGET 2",
                                       sliderInput(inputId = "slider1",
                                                   label = h3("Temperature (C)"),
                                                   min = 0,
                                                   max = 100,
                                                   value = 50),
                                       "WIDGET 3",
                                       sliderInput(inputId = "slider2",
                                                   label = h3("Salinity (ppt)"),
                                                   min = 30,
                                                   max = 40,
                                                   value = 35)
                          ),
                          mainPanel("OUTPUT 2",
                                    "OUTPUT 3"))
                      ),
             tabPanel("Tab 3",
                      sidebarLayout(
                          sidebarPanel("WIDGET 4",
                                       checkboxGroupInput(inputId = "checkGroup",
                                                   label = h3("Marine Activities"),
                                                   choices = list(
                                                       "Marine Protected Areas" = 1, "Oil and Gas Wells/Platforms" = 2, "Danger and Restricted Zones" = 3),
                                                   selected = 1)
                          ),
                          mainPanel("OUTPUT 4"))
             )

  )

)

# Create the server:
server <- function(input, output) {


    output$img <- renderUI({
      if(input$pick_species == 1){
        img(height = 240, width = 300, src = 'eucheuma.png')
      }
      else if(input$pick_species == 2){
        img(height = 240, width = 300, src = 'gracilaria.png')
      }
      else if(input$pick_species == 3){
        img(height = 240, width = 300, src = 'sargassum.png')
      }
      })


}

# Combine ui and server to run the application
shinyApp(ui = ui, server = server)




