# This is our seaweed shiny app!
library(raster)
library(tidyverse)
library(shiny)
library(shinythemes)
library(sdmpredictors)
library(maps)
library(mapdata)
library(here)

# Create the user interface:
ui <- fluidPage(theme = "app_theme.css",

  navbarPage("Seaweed Suitability in the Gulf of Mexico",
             tabPanel("About",
                      sidebarLayout(
                        sidebarPanel(width = 6,
                          img(height = "100%", width = "100%", src = 'seaweed_farm_placeholder.png'),
                                     tags$style(".well {background-color: ivory;}")
                                     ),
                        mainPanel(width = 11, column(11, offset = 1,
                                         h2("Authors: Laurel Abowd, Jaleise Hall, & Sydney Rilum"),
                                         h1("Introduction"),
                                         h2(p("This Shiny App has a two-fold purpose: 1) to explore seaweed aquaculture’s application for nutrient assimilation (i.e. bioremediation) in the Gulf of Mexico, and 2) to help visualize findings from Racine, P., Marley, A., Froehlich, H. E., Gaines, S. D., Ladner, I., MacAdam-Somer, I., & Bradley, D. (2021). A case for seaweed aquaculture inclusion in US nutrient pollution management. Marine Policy, 129, 104506. https://doi.org/10.1016/j.marpol.2021.104506. To note, this Shiny App does not include all human use or biotic data layers used in Racine et. al. (2021).")),
                                         h1("Overview"),
                                         h2(tags$ul(
                                                 tags$li("The first tab introduces viewers <em>Gracilaria tikvahiae</em>, <em>Sargassum spp.</em>, <em>Eucheuma spp.</em> and <em>Ulva spp.</em> (<em>U. prolifera</em>). Background information on the spread of seaweed populations as well as abiotic restrictions associated with the given species are addressed within the content of this tab."),
                                                 tags$li("The second tab allows the user to select between various suitability and exclusion factors for seaweed aquaculture and observe the locations where seaweed aquaculture can physically thrive and where it is physically not allowed, depending on each factor."),
                                                 tags$li("The third tab displays the combined suitable areas and the combined exclusion areas. When both choices are selected, the suitable and exclsuion layers are combined, revealing the potential seaweed aquaculture sites in the Gulf of Mexico."))),
                                         ),
                                         br(),
                                         )#add parenthesis here
                                  ))
                      ),

             tabPanel("Seaweed Species",
                      sidebarLayout(
                        sidebarPanel(width = 4, selectInput(inputId = "pick_species",
                                                 label = h5("Seaweed Species"),
                                                 choices = list(
                                                   "Gracilaria tikvahiae" = 1,
                                                   "Sargassum spp." = 2,
                                                   "Eucheuma spp." = 3,
                                                   "Ulva spp." = 4),
                                                 selected = 1),
                                     ), #take out one parenthesis
                        mainPanel(width = 12,
                                  uiOutput("img"),
                                  textOutput("text")
                                  ))
                      ),
             tabPanel("Suitability & Exclusion Factors",
                      sidebarLayout(
                        sidebarPanel(radioButtons(inputId = "radio1",
                                                  label = h5("Suitability Factors"),
                                                  choiceNames = list(
                                                    tags$span("Depth", style = "color: black;"),
                                                    tags$span("Salinity", style = "color: black;"),
                                                    tags$span("Current Velocity", style = "color: black;"),
                                                    tags$span("Nitrogen:Phosphorus Ratio", style = "color: black;")),
                                                  choiceValues = c("1", "2", "3", "4"),
                                                  selected = 1),
                                     radioButtons(inputId = "radio2",
                                                  label = h5("Exclusion Factors"),
                                                  choiceNames = list(
                                                    tags$span("Marine Protected Areas", style = "color: black;"),
                                                    tags$span("Shipping Lanes", style = "color: black;"),
                                                    tags$span("Military Danger Zones", style = "color: black;")),
                                                  choiceValues = c("1", "2", "3"),
                                                  selected = 1),
                                     ),
                        mainPanel(uiOutput("suitability"),
                                  uiOutput("exclusion")
                                  ))
                      ),
             tabPanel("Potential Aquaculture Sites",
                      sidebarLayout(
                        sidebarPanel(checkboxGroupInput(inputId = "checkGroup",
                                                        label = h5("Potential Seaweed Aquaculture Sites"),
                                                        choiceNames = list(
                                                          tags$span("Combined Suitability factors", style = "color: black;"),
                                                          tags$span("Combined Exclusion factors", style = "color: black;")
                                                          ),
                                                        choiceValues = c("1", "2")
                                                        ),
                          ),
                        mainPanel(h2("Select both boxes to reveal the potential seaweed aquaculture sites.", style = "color: black;"),
                                  uiOutput("potential_sites")
                                  ))
                      )
             )
  )

# Create the server:
server <- function(input, output) {


    output$img <- renderUI({
      if(input$pick_species == 1){
        img(height = "100%", width = "100%", src = 'gracilaria.png')
      }
      else
        if(input$pick_species == 2){
        img(height = "100%", width = "100%", src = 'sargassum.png')
      }
      else
        if(input$pick_species == 3){
        img(height = "100%", width = "100%", src = 'eucheuma.png')
      }
      else
        if(input$pick_species == 4){
        img(height = "100%", width = "100%", src = 'ulva.png')
      }
      })

    output$tab1text <- renderText(h3(output$text))


    output$suitability <- renderPrint({
      if(input$radio1 == "1"){
        img(height = "85%", width = "85%", src = 'depth_map_trim.png')
      }
      else
        if(input$radio1 == "2"){
          img(height = "85%", width = "85%", src = 'salinity_map_trim.png')
        }
      else
        if(input$radio1 == "3"){
          img(height = "85%", width = "85%", src = 'current_velocity_map_trim.png')
        }
      else
        if(input$radio1 == "4"){
          img(height = "85%", width = "85%", src = 'np_ratio_map_trim.png')
        }
    })

    output$exclusion <- renderPrint({
      if(input$radio2 == "1"){
        img(height = "85%", width = "85%", src = 'mpa_map_trim.png')
      }
      else
        if(input$radio2 == "2"){
          img(height = "85%", width = "85%", src = 'shipping_lanes_map_trim.png')
        }
      else
        if(input$radio2 == "3"){
          img(height = "85%", width = "85%", src = 'military_map_trim.png')
        }
    })

    output$potential_sites <- renderPrint({
      if(length(input$checkGroup) == 0){
        img(height = "70%", width = "70%", src = 'blue_background.png')
        }

      else if(length(input$checkGroup) == 1){
        if(input$checkGroup == "1"){
        img(height = "85%", width = "85%", src = 'suitable_areas_map_trim.png')
        } else if(input$checkGroup == "2"){
          img(height = "85%", width = "85%", src = 'exclusion_areas_map_trim.png')
        }
      }

      else if(length(input$checkGroup) == 2)
        {
          img(height = "85%", width = "85%", src = 'seaweed_map_trim.png')
        }
    })

}

# Combine ui and server to run the application
shinyApp(ui = ui, server = server)




