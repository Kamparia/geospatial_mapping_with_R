
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RColorBrewer)

ui <- bootstrapPage(

  tags$head(
    # Include our custom CSS
    includeCSS("./assets/styles.css")
  ),  
  
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10, id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, height = "auto",                
                
    # Application title
    titlePanel("Minneapolis Crime Data"),        
    
    sliderInput("range", "Magnitudes", min(quakes$mag), max(quakes$mag),
                value = range(quakes$mag), step = 0.1
    ),
    
    selectInput("offense", "Type of Offense",
                rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
    ),
    
    checkboxInput("legend", "Show legend", TRUE)
  )
)