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
                                         h2(p("A group of researchers including Anna Claire Marley, Phoebe Racine, and Gabriel de la Rosa at the Bren School of Enviromental Science & Management began this project with the goal encouraging an increase in seaweed aquaculture in order to better take advantage of the natural nutrient removal capabilities of seaweed species which can attribute to eutrophication stabilization and pollution reduction. This project looks at various abiotic restrictions and marine activities to determine areas most suitable to carry out a more developed venture of seaweed aquaculture in the Gulf of Mexico. These restrictions and activities include sea surface temperature, salinity, water depth, presence of shipping lanes, cable areas, pipelines, military bases, oil and gas platforms, and other areas generally dangerous for the seaweed to inhabit. While carbon extraction was briefly considered, this study focuses mainly on seaweeds effect on Nitrogen and Phosphorous removal and the impacts on productivity and water quality. Currently, the study has been isolated to the Gulf of Mexico; however the group has expanded their research, mapping out the anthropogenic pollution over the United States. With pollution increasing at alarming rates around the world, the findings in this study laid out in the final report are very important to address.")),
                                         h1("Summary"),
                                         h2(p("Our shiny app explores this potential for seaweed aquaculture to remediate nutrient pollution on a large scale using the Gulf of Mexico as a case. The two species considered in the study and reflected in this app are Gracilaria tikvahiae and Sargassum spp. The purpose of this app is to visualize the findings of the study and allow the use of an interactive tool to help push the idea of the potential for a seaweed aquaculture market.")),
                                         h1("Overview"),
                                         h2(tags$ul(
                                                 tags$li("The first tab introduces viewers to the two study species as well as two other important seaweed species Eucheuma spp and Ulva spp (U. prolifera). Background information on the spread of seaweed populations as well as abiotic restrictions associated with the given species are addressed within the content of this tab."),
                                                 tags$li("The second tab allows the user to select between various suitability and exclusion factors for seaweed aquaculture and observe the locations where seaweed aquaculture can physically thrive and where it is physically not allowed, depending on each factor."),
                                                 tags$li("The third tab displays the combined suitable areas and the combined exclusion areas. When both choices are selected, the suitable and exclsuion layers are combined, revealing the potential seaweed aquaculture sites in the Gulf of Mexico."))),
                                         h3("Citations"),
                                         h4(p("admin. (2016, March 21). Caribbean scientists to meet to address prevalence of sargassum seaweed. Caribbean News. https://www.caribbeannationalweekly.com/caribbean-breaking-news-featured/caribbean-scientists-address-sargassum-seaweed/"),
                                            p("Becker, R. A., & Wilks, A. R.. & Brownrigg, R. & Minka, T. P., & Deckmyn, A. (2018). maps: Draw Geographical Maps. R package version 3.3.0. https://CRAN.R-project.org/package=maps"),
                                            p("Bosch, S. (2020). sdmpredictors: Species Distribution Modelling Predictor Datasets. R package version 0.2.9. https://CRAN.R-project.org/package=sdmpredictors"),
                                            p("Eucheuma denticulatum. (2018, February 14). Wikipedia. https://en.wikipedia.org/wiki/Eucheuma_denticulatum"),
                                            p("Gorman, L., Kraemer, G. P., Yarish, C., Boo, S. M., & Kim, J. K. (2017). The effects of temperature on the growth rate and nitrogen content of invasive Gracilaria vermiculophylla and native Gracilaria tikvahiae from Long Island Sound, USA. ALGAE, 32(1), 57–66. https://doi.org/10.4490/algae.2017.32.1.30"),
                                            p("Hijmans, R. J. (2020). raster: Geographic Data Analysis and Modeling. R package version 3.4-5. https://CRAN.R-project.org/package=raster"),
                                            p("Hiraoka, M., Ichihara, K., Zhu, W., Ma, J., & Shimada, S. (2011). Culture and Hybridization Experiments on an Ulva Clade Including the Qingdao Strain Blooming in the Yellow Sea. PLoS ONE, 6(5), e19371. https://doi.org/10.1371/journal.pone.0019371"),
                                            p("Kim, J. K., Kraemer, G. P., & Yarish, C. (2014). Field scale evaluation of seaweed aquaculture as a nutrient bioextraction strategy in Long Island Sound and the Bronx River Estuary. Aquaculture, 433, 148–156. https://doi.org/10.1016/j.aquaculture.2014.05.034"),
                                            p("Liu, D., Keesing, J. K., He, P., Wang, Z., Shi, Y., & Wang, Y. (2013). The world’s largest macroalgal bloom in the Yellow Sea, China: Formation and implications. Estuarine, Coastal and Shelf Science, 129, 2–10. https://doi.org/10.1016/j.ecss.2013.05.021"),
                                            p("Ooms, J. (2021). magick: Advanced Graphics and Image-Processing in R. R package version 2.7.1. https://CRAN.R-project.org/package=magick "),
                                            p("Racine, P., Marley, A. C., & de la Rosa, G. (n.d.). A case for seaweed aquaculture inclusion in U.S. nutrient pollution management."),
                                            p("South, A. (2017). rnaturalearth: World Map Data from Natural Earth. R package version 0.1.0. https://CRAN.R-project.org/package=rnaturalearth"),
                                            p("Wang, M., Hu, C., Barnes, B. B., Mitchum, G., Lapointe, B., & Montoya, J. P. (2019). The great Atlantic Sargassum belt. Science, 365(6448), 83–87. https://doi.org/10.1126/science.aaw7912"),
                                            p("Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686"),
                                            p("Wiedenhoft, H. (2019, November 20). Seaweed farming gains traction. Aquaculture North America. https://www.aquaculturenorthamerica.com/seaweed-farming-gains-traction/"),
                                            p("WoRMS - World Register of Marine Species - Eucheuma J.Agardh, 1847. (n.d.). Www.marinespecies.org. Retrieved March 5, 2021, from http://www.marinespecies.org/aphia.php?p=taxdetails&id=206475#distributions"),
                                            p("WoRMS - World Register of Marine Species - Gracilaria tikvahiae McLachlan, 1979. (n.d.). Www.marinespecies.org. Retrieved March 5, 2021, from http://www.marinespecies.org/aphia.php?p=taxdetails&id=157354"),
                                            p("WoRMS - World Register of Marine Species - Sargassum C.Agardh, 1820. (n.d.). Www.marinespecies.org. http://www.marinespecies.org/aphia.php?p=taxdetails&id=144132#notes"),
                                            p("WoRMS - World Register of Marine Species - Ulva prolifera O.F.Müller, 1778. (n.d.). Www.marinespecies.org. Retrieved March 5, 2021, from http://www.marinespecies.org/aphia.php?p=taxdetails&id=234476#distributions"),
                                            p("Youssef. (2019, March 25). Gracilaria Supplier and Exporter in Morocco. Morocco Seaweed. https://www.morocco-seaweed.com/gracilaria/

")),
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




