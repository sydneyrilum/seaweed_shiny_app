# This is our seaweed shiny app!

library(tidyverse)
library(shiny)
library(shinythemes)

# Create the user interface:
ui <- fluidPage(theme = "app_theme.css",

  navbarPage("Seaweed Suitability in the Gulf of Mexico",
             tabPanel("About",
                      sidebarLayout(
                        sidebarPanel(img(height = "200%", width = "200%", src = 'seaweed_farm_placeholder.png'),
                                     tags$style(".well {background-color: ivory;}")
                                     ),
                        mainPanel(column(10, offset = 5,
                                         h1("Introduction"),
                                         h2(p("about the project")),
                                         br(),
                                         h1("Summary"),
                                         h2(p("about the app")),
                                         br(),
                                         h1("Overview"),
                                         h2(p("tab overview and features")),
                                         h3("Citations"),
                                         h4(p("list citations here"))
                                         )
                                  ))
                      ),

             tabPanel("Tab 1",
                      sidebarLayout(
                        sidebarPanel(selectInput(inputId = "pick_species",
                                                 label = h5("Seaweed Species"),
                                                 choices = list(
                                                   "Gracilaria tikvahiae" = 1,
                                                   "Sargassum spp." = 2,
                                                   "Eucheuma" = 3),
                                                 selected = 1),
                                     ),
                        mainPanel(textOutput("text"),
                                  uiOutput("img")
                                  ))
                      ),
             tabPanel("Tab 2",
                      sidebarLayout(
                        sidebarPanel(sliderInput(inputId = "slider1",
                                                 label = h5("Temperature (C)"),
                                                 min = 0,
                                                 max = 100,
                                                 value = 50),
                                     sliderInput(inputId = "slider2",
                                                 label = h5("Salinity (ppt)"),
                                                 min = 30,
                                                 max = 40,
                                                 value = 35)
                                     ),
                        mainPanel("OUTPUT 2 + 3"
                                  ))
                      ),
             tabPanel("Tab 3",
                      sidebarLayout(
                        sidebarPanel(checkboxGroupInput(inputId = "checkGroup",
                                                        label = h5("Marine Activities"),
                                                        choiceNames = list(
                                                          tags$span("Marine Protected Areas", style = "color: black;"),
                                                          tags$span("Oil and Gas Wells/Platforms", style = "color: black;"),
                                                          tags$span("Danger and Restricted Zones", style = "color: black;")
                                                          ),
                                                        choiceValues = c("1", "2", "3"),
                                                        selected = 1)
                          ),
                        mainPanel("OUTPUT 4"
                                  ))
                      )
             )
  )

# Create the server:
server <- function(input, output) {


    output$img <- renderUI({
      if(input$pick_species == 1){
        img(height = "75%", width = "75%", src = 'gracilaria.png')
      }
      else
        if(input$pick_species == 2){
        img(height = "75%", width = "75%", src = 'sargassum.png')
      }
      else
        if(input$pick_species == 3){
        img(height = "75%", width = "75%", src = 'eucheuma.png')
      }
      })

    output$text <- renderText({
      if(input$pick_species == 1){
        "insert overview paragraph for Gracilaria tikvahiae here "
      }
      else
        if(input$pick_species == 2){
        "insert overview paragraph for Sargassum spp. here"
      }
      else
        if(input$pick_species == 3){
        "insert overview paragraph for Eucheuma spp. here"
      }
      })

    output$tab1text <- renderText(h3(output$text))


}

# Combine ui and server to run the application
shinyApp(ui = ui, server = server)




