
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(rsconnect)
library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

source('global.R')

shinyServer(function(input, output) {
  # Function to plot Leaflet Map based on given data
  plotMap <- function(data){
    leaflet(data = data[]) %>% addProviderTiles("CartoDB.Positron") %>% addMarkers(
      ~Longitude, 
      ~Latitude, 
      popup = ~as.character(Description),
      clusterOptions = markerClusterOptions()
    )    
  }
  
  # Function to ploy Chart based on given data
  plotChart <- function(data){
    data$Month <- factor(data$Month, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
    # Plot Bar Chart showing crimes bases on Month
    ggplot(data, aes(Month, fill=Month) ) + 
      geom_bar(width = 0.25) + 
      ggtitle("Graph showing total arrests against month.") + 
      xlab("Month") + 
      ylab("Total Crimes") + 
      labs(fill = "Month") + 
      theme(
        legend.position = "none"
      )
  }
  
  # UI Selected input components - reactive
  offense <- reactive({
    input$offense
  })
  neighborhood <- reactive({
    input$neighborhood
  })
  
  output$map <- renderLeaflet({
    if( offense() == input$offense ){
      crimes <- filter(.data = crimes, Description == input$offense)
      plotMap(crimes)
      if ( neighborhood() == input$neighborhood ){
        crimes <- filter(.data = crimes, Neighborhood == input$neighborhood)
        plotMap(crimes)              
      }else{
        
      }
    }
    else if( neighborhood() == input$neighborhood  ){
      crimes <- filter(.data = crimes, Neighborhood == input$neighborhood)
      plotMap(crimes)      
    }
    else{
      plotMap(crimes)
    }    
    
  })
  
  output$datachart <- renderPlot({
    plotChart(crimes)
    if( offense() == input$offense ){
      crimes <- filter(.data = crimes, Description == input$offense)
      plotChart(crimes)
      if ( neighborhood() == input$neighborhood ){
        crimes <- filter(.data = crimes, Neighborhood == input$neighborhood)
        plotChart(crimes)              
      }else{
        
      }
    }
    else if( neighborhood() == input$neighborhood  ){
      crimes <- filter(.data = crimes, Neighborhood == input$neighborhood)
      plotChart(crimes)  
    }
    else{
      plotChart(crimes)
    }        
  })

})
