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
                                         h2(p("This Shiny App has a two-fold purpose: 1) to explore seaweed aquaculture’s application for nutrient assimilation (i.e. bioremediation) in the Gulf of Mexico, and 2) to help visualize findings from Racine, P., Marley, A., Froehlich, H. E., Gaines, S. D., Ladner, I., MacAdam-Somer, I., & Bradley, D. (2021). A case for seaweed aquaculture inclusion in U.S. nutrient pollution management. Marine Policy, 129, 104506. https://doi.org/10.1016/j.marpol.2021.104506. To note, this Shiny App does not include all human use or biotic data layers used in Racine et al. (2021).")),
                                         h1("Overview"),
                                         h2(tags$ul(
                                                 tags$li(div(HTML("The first tab introduces viewers <em>Gracilaria tikvahiae</em>, <em>Sargassum spp.</em>, <em>Eucheuma spp.</em> and <em>Ulva spp.</em> (<em>U. prolifera</em>). Background information on the spread of seaweed populations as well as abiotic restrictions associated with the given species are addressed within the content of this tab."))),
                                                 tags$li("The second tab allows the user to select between various suitability and exclusion factors to map seaweed aquaculture potential in The Gulf of Mexico."),
                                                 tags$li("The third tab displays the combined suitable areas and the combined exclusion areas. When both choices are selected, the suitable and exclsuion layers are combined, revealing the potential seaweed aquaculture sites in the Gulf of Mexico."))),
                                         ),
                                         br(),
                                         )#add parenthesis here
                                  ))
                      ,

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
                        mainPanel(#width = 12,
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
                      ),
             br()
             ))


# Create the server:
server <- function(input, output) {


    output$img <- renderUI({
      if(input$pick_species == 1){
        img(height = "100%", width = "100%", src = 'gracilaria_img.png')
      }
      else
        if(input$pick_species == 2){
        img(height = "100%", width = "100%", src = 'sargassum_img.jpeg')
      }
      else
        if(input$pick_species == 3){
        img(height = "100%", width = "100%", src = 'eucheuma_img.jpeg')
      }
      else
        if(input$pick_species == 4){
        img(height = "100%", width = "100%", src = 'ulva_img.png')
      }
      })

    output$text <- renderText({
      if(input$pick_species == 1){
        "Part of the family Gracilariaceae, Gracilaria tikvahiae is native to the Long Island Sound and Newfoundland coasts. G. tikvahiae also less heavily populates areas in the North Pacific Ocean, the Northwest Atlantic Ocean, the Gulf of Maine, and was introduced to Hawaii. G. tikvahiae also has a population in the Gulf of Mexico, allowing the species to be one of the two main seaweed species observed in this study. Through information collected in the study, it was found that the dry weight of Nitrogen (N) in G. tikvahiae is 3.9% while the dry weight of Phosphorus (P) is 0.04%. This species is often found in shallow sublittoral and sheltered waters at depths of two to five meters (cite) and can be rather sensitive to temperature shifts, more so than G. tikvahiae’s Korea-native relative G. vermiculophylla. The abiotic restrictions used to measure suitable areas for seaweed aquaculture using the two study species included sea temperature and salinity. For G. tikvahiae this meant that temperature range must be within 15 – 34℃ and the salinity must be within 8 – 60 PSU (Practical Salinity Unit)."
      }
      else
        if(input$pick_species == 2){
          "Sargassum spp is a group of seaweed species belonging to the Sargassaceae family of seaweed. This group of seaweed is known to attract an array of aquatic and semi-aquatic organisms, allowing for high biodiversity and productivity. Sargassum spp is able to provide habitats for fish, shrimp, crabs, birds, and turtles (cite). This group of seaweed resides in seamounts and knolls around the Mediterranean Sea, Republic of Mauritius, Northern European Seas, and, more relevant for this study, the Gulf of Mexico. Sargassum spp is the second seaweed species observed in this study and has dry N and P weights of 2.5% and 0.3% respectively. For the abiotic restrictions, a suitable habitat for Sargassum spp must be within 18 – 30℃ and salinity within 24 – 42 PSU. Sargassum spp can also be found floating in the Sargasso Sea (named after the seaweed itself) where S. fluitans and S. natans are found to be the most abundant. With the study period set between 2010 and 2012, it is important to note the first massive Sargassum spp bloom which occurred in 2011 in central Atlantic reaching all the way to the Gulf of Mexico. Suitable sea temperatures and an influx of nutrient from upwelling in 2010 allowed for this bloom to come about."
        }
      else
        if(input$pick_species == 3){
          "Following the Gulf of Mexico study, the team of Bren School of Environmental Science researchers plan to explore the potential for Eucheuma spp as another seaweed bio-extractor. Eucheuma spp is part of the Solieriaceae family and is found in Brazil, Djibouti, and Venezuela. What is interesting about Eucheuma is that it is an alien species in all of these areas and acts as more of a commercial crop. For the abiotic restrictions, Eucheuma spp must grow in habitats of 25 – 30℃ for sea surface temperature and 28 – 34 PSU for salinity to maintain acceptable levels of suitability."
        }
      else
        if(input$pick_species == 4){
          "Ulva spp is a group of seaweed in the Ulvacae family, and although not an observed species in the Gulf of Mexico study, it is a relevant species for discussing the potential for the increase in seaweed aquaculture and is often addressed in the study. In particular the Ulva prolifera algal bloom from 2008 – 2012 in the Yellow Sea near Qingdao, the world’s largest trans-regional macroalgal bloom, was referenced on multiple occasions throughout the Gulf of Mexico paper. Ulva spp including U. prolifera is a highly widespread group of seaweed and is found in a large percentage of Earth’s marine ecosystems. Seaweed farming associated with the species has been known to help stabilize eutrophication in coastal China."
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




