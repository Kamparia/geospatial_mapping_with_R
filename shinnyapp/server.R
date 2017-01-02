
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {

  # Import Crimes_2015 datasets
  crimes <- read.csv('../eda/Crimes_2015.csv', header = TRUE, stringsAsFactors = TRUE)
  
  output$map <- renderLeaflet({

    # Plot a clustered map of the first 1000 rows
    leaflet(data = crimes[1:1000,]) %>% addProviderTiles("CartoDB.Positron") %>% addMarkers(
      ~Longitude, 
      ~Latitude, 
      popup = ~as.character(Description),
      clusterOptions = markerClusterOptions()
    )    
    
  })  
  
})
