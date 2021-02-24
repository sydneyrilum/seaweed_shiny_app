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
                        sidebarPanel(img(height = "150%", width = "150%", src = 'seaweed_farm_placeholder.png'),
                                     tags$style(".well {background-color: ivory;}")
                                     ),
                        mainPanel(column(10, offset = 2,
                                         h1("Introduction"),
                                         h2(p("A group of researchers including AnnaClaire Marley, Phoebe Racine, Gabriel de la Rosa at the Bren School of Enviromental Science & Management began this project with the goal encouraging an increase in seaweed aquaculture in order to better take advantage of the natural nutrient removal capabilities of seaweed species which can attribute to eutrophication stabilization and pollution reduction. This project looks at various abiotic restrictions and marine activities to determine areas most suitable to carry out a more developed venture of seaweed aquaculture in the Gulf of Mexico. These restrictions and activities include sea surface temperature, salinity, water depth, presence of shipping lanes, cable areas, pipelines, military bases, oil and gas platforms, and other areas generally dangerous for the seaweed to inhabit. While carbon extraction was briefly considered, this study focuses mainly on seaweeds effect on Nitrogen and Phosphorous removal and the impacts on productivity and water quality. Currently, the study has been isolated to the Gulf of Mexico, be the group has begun expanding their research and mapping out the anthropogenic pollution over the United States. With pollution increasing at alarming rates around the world, the findings in this study laid out in the final report are very important to address.")),
                                         br(),
                                         h1("Summary"),
                                         h2(p("Our shiny app explores this potential for seaweed aquaculture to remediate nutrient pollution on a large scale using the Gulf of Mexico as a case. The two species considered in the study and reflected in this app are Gracilaria tikvahiae and Sargassum spp. The purpose of this app is to visualize the findings of the study and allow the use of an interactive tool to help push the idea of a more development seaweed aquaculture market.")),
                                         br(),
                                         h1("Overview"),
                                         h2(p("The first tab introduces viewers to the two study species as well as two other important seaweed species Eucheuma spp and Ulva spp (U. prolifera). Background information on the spread of seaweed populations as well as abiotic restrictions associated with the given species are addressed within the content of this tab. The next tab adds a visualization to the abiotic features of the two study species and how suitability based on those restrictions evolved over the 2010 -2012 study period. The final tab explores the exclusions associated with various marine activities which may take precedence over aquaculture sites (e.g. shipping lanes, MPAs, military areas, oil rigs/wells).")),
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
                                                   "Eucheuma spp." = 3,
                                                   "Ulva spp." = 4),
                                                 selected = 1),
                                     ),
                        mainPanel(uiOutput("img"),
                                  textOutput("text")
                                  ))
                      ),
             tabPanel("Tab 2",
                      sidebarLayout(
                        sidebarPanel(radioButtons(inputId = "radio1",
                                                  label = h5("Suitability Factors"),
                                                  choiceNames = list(
                                                    tags$span("Depth", style = "color: black;"),
                                                    tags$span("Salinity", style = "color: black;"),
                                                    tags$span("Current velocity", style = "color: black;"),
                                                    tags$span("Nitrogen:Phosphorus ratio", style = "color: black;")),
                                                  choiceValues = c("1", "2", "3", "4"),
                                                  selected = 1),
                                     radioButtons(inputId = "radio2",
                                                  label = h5("Exclusion Factors"),
                                                  choiceNames = list(
                                                    tags$span("Marine Protected Areas", style = "color: black;"),
                                                    tags$span("Shipping lanes", style = "color: black;"),
                                                    tags$span("Pipelines", style = "color: black;"),
                                                    tags$span("Military danger zones", style = "color: black;"),
                                                    tags$span("Oil and gas platforms", style = "color: black;")),
                                                  choiceValues = c("1", "2", "3", "4", "5"),
                                                  selected = 1),
                                     ),
                        mainPanel(uiOutput("suitability"),
                                  uiOutput("exclusion")
                                  ))
                      ),
             tabPanel("Tab 3",
                      sidebarLayout(
                        sidebarPanel(checkboxGroupInput(inputId = "checkGroup",
                                                        label = h5("Potential Seaweed Aquaculture Sites:"),
                                                        choiceNames = list(
                                                          tags$span("Combined exclusion factors", style = "color: black;"),
                                                          tags$span("Combined suitability factors", style = "color: black;")
                                                          ),
                                                        choiceValues = c("1", "2")
                                                        )
                          ),
                        mainPanel(plotOutput("potential_sites")
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
      else
        if(input$pick_species == 4){
        img(height = "75%", width = "75%", src = 'ulva.png')
      }
      })

    output$text <- renderText({
      if(input$pick_species == 1){
        "Part of the family Gracilariaceae, Gracilaria tikvahiae is native to the Long Island Sound and Newfoundland coasts. G. tikvahiae also less heavily populates areas in the North Pacific Ocean, the Northwest Altantic Ocean, the Gulf of Maine, and was introduced to Hawaii in [add year?]. G. tikvahiae also has a population in the Gulf of Mexico, allowing the species to be one of the two main seaweed species observed in this study. Through information collected in the study, it was found that the dry weight of Nitrogen (N) in G. tikvahiae is 3.9% while the dry weight of Phosphorous (P) is 0.04%. This species is often found in shallow sublittoral and sheltered waters at depths of two to five meters (cite) and can be rather sensitive to temperature shifts, more so than G. tikvahiae’s Korea-native relative G. vermiculophylla. The abiotic restrictions used to measure suitable areas for seaweed aquaculture using the two study species included sea temperature and salinity. For G. tikvahiae this meant that temperature range must be within 15 – 34C and the salinity must be within 8 – 60 PSU (Practical Salinity Unit)."
      }
      else
        if(input$pick_species == 2){
        "Sargassum spp is a group of seaweed species belonging to the Sargassaceae family of seaweed. This group of seaweed is known to attract an array of aquatic and semi-aquatic organisms, allowing for high biodiversity and productivity. Sargassum spp is able to provide habitats for fish, shrimp, crabs, birds, and turtles (cite). This group of seaweed resides in seamounts and knolls around the Mediterranean Sea, Republic of Mauritius, Northern European Seas, and, more relevant for this study, the Gulf of Mexico. Sargassum spp is the second seaweed species observed in this study and has dry N and P weights of 2.5% and 0.3% respectively. For the abiotic restrictions, a suitable habitat for Sargassum spp must be within 18 – 30C and salinity within 24 – 42 PSU. Sargassum spp can also be found floating in the Sargasso Sea (named after the seaweed itself) where S. fluitans and S. natans are found to be the most abundant. With the study period set between 2010 and 2012, it is important to note the first massive Sargassum spp bloom which occurred in 2011 in central Altantic reaching all the way to the Gulf of Mexico. Suitable sea temperatures and an influx of nutrient from upwelling in 2010 allowed for this bloom to come about."
      }
      else
        if(input$pick_species == 3){
        "Following the Gulf of Mexico study, the team of Bren School of Environmental Science researchers plan to explore the potential for Eucheuma spp as another seaweed bio-extractor. Eucheuma spp is part of the Solieriaceae family and is found in Brazil, Djibouti, and Venezuela. What is interesting about Eucheuma is that it is an alien species in all of these areas and acts as more of a commercial crop. For the abiotic restrictions, Eucheuma spp must grow in habitats of 25 – 30C for sea surface temperature and 28 – 34 PSU for salinity to maintain acceptable levels of suitability."
      }
      else
        if(input$pick_species == 4){
        "Ulva spp is a group of seaweed in the Ulvacae family, and although not an observed species in the Gulf of Mexico study, it is a relevant species for discussing the potential for the increase in seaweed aquaculture and is often addressed in the study. In particular the Ulva prolifera algal bloom from 2008 – 2012 in the Yellow Sea near Qingdao, the world’s largest trans-regional macroalgal bloom, was referenced on multiple occasions throughout the Gulf of Mexico paper. Ulva spp including U. prolifera is a highly widespread group of seaweed and is found in a large percentage of Earth’s marine ecosystems. Seaweed farming associated with the species has been known to help stabilize eutrophication in coastal China."
      }
      })

    output$tab1text <- renderText(h3(output$text))


    output$suitability <- renderPrint({
      if(input$radio1 == "1"){
        img(height = "75%", width = "75%", src = 'gracilaria.png')
      }
      else
        if(input$radio1 == "2"){
          img(height = "75%", width = "75%", src = 'sargassum.png')
        }
      else
        if(input$radio1 == "3"){
          img(height = "75%", width = "75%", src = 'eucheuma.png')
        }
      else
        if(input$radio1 == "4"){
          img(height = "75%", width = "75%", src = 'ulva.png')
        }
    })

    output$exclusion <- renderPrint({
      if(input$radio2 == "1"){
        img(height = "75%", width = "75%", src = 'gracilaria.png')
      }
      else
        if(input$radio2 == "2"){
          img(height = "75%", width = "75%", src = 'sargassum.png')
        }
      else
        if(input$radio2 == "3"){
          img(height = "75%", width = "75%", src = 'eucheuma.png')
        }
      else
        if(input$radio2 == "4"){
          img(height = "75%", width = "75%", src = 'ulva.png')
        }
      else
        if(input$radio2 == "5"){
          img(height = "75%", width = "75%", src = 'ulva.png')
        }
    })

    seaweed_reactive <- reactive({
      # Marine protected areas
      mpa <- raster(paste0(here("data", "Active_Data_Layers", "mpas_binary_hy.tif")))
    })



    output$potential_sites <- renderPlot({
      if(identical(input$checkGroup, 1)){
        img(height = "75%", width = "75%", src = 'sargassum.png')
      }
      else
        if(identical(input$checkGroup, 2)){
          img(height = "75%", width = "75%", src = 'ulva.png')
        }
      else
        if(identical(input$checkGroup, c(1,2))){
          img(height = "75%", width = "75%", src = 'euchema.png')
        }
    })



}

# Combine ui and server to run the application
shinyApp(ui = ui, server = server)




