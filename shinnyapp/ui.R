
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)

ui <- bootstrapPage(

  tags$head(
    # Include our custom CSS
    includeCSS("./assets/styles.css")
  ),  
  
  leafletOutput("map", width = "100%", height = "100%"),

  absolutePanel(top = 10, right = 10, id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, height = "auto",                
    # Application title
    titlePanel("2015 Minneapolis Crime Data"),
    #selectInput("year", "Year", choices = crimes$Year, selected = "2010"),
    selectInput("offense", "Type of Offense", choices = crimes$Description, selected = ""),
    selectInput("neighborhood", "Neighborhood", choices = crimes$Neighborhood, selected = ""),
    plotOutput("datachart", height = 200)
  ),
  
  tags$div(id="cite",
           'Data source : Mineapolis Open Data (http://opendata.minneapolismn.gov/)'
  )
)