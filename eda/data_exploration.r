# Import R Packages and Modules
library("ggplot2")
library("dplyr")
library("leaflet")

# Import Crimes_2015 datasets
crimes <- read.csv('Crimes_2015.csv', header = TRUE, stringsAsFactors = TRUE)

# Plot Bar Chart showing crimes bases on Offense types
ggplot(crimes, aes(Offense, fill=Offense) ) + geom_bar() + ggtitle("Graph showing arrests based on types of offense.") + xlab("Offense") + ylab("Total Crimes") + labs(fill = "Offense types")

# Plot Bar Chart showing crimes bases on neighborhood
ggplot(crimes, aes(Neighborhood, fill=Neighborhood) ) + geom_bar() + ggtitle("Graph showing arrests based on Neighborhood.") + xlab("Neighborhood") + ylab("Total Crimes") + labs(fill = "Neighborhood")

# Plot Bar Chart showing crimes bases on Month
ggplot(crimes, aes(Month, fill=Month) ) + geom_bar(width = 0.5) + ggtitle("Graph showing arrests based on Month of crime.") + xlab("Month") + ylab("Total Crimes") + labs(fill = "Month")

# Plot Bar Chart showing crimes bases on Precinct
ggplot(crimes, aes(Precinct, fill=Precinct) ) + geom_bar(width = 0.5) + ggtitle("Graph showing arrests based on Precinct.") + xlab("Precinct") + ylab("Total Crimes") + labs(fill = "Precinct")

# Plot a map showing the first 20 rows from the `crimes` dataset
leaflet(data = crimes[1:20,]) %>% addTiles() %>%
  addMarkers(~Longitude, ~Latitude, popup = ~as.character(Description))

# Plot a clustered map of the first 1000 rows
leaflet(data = crimes[1:1000,]) %>% addProviderTiles("CartoDB.Positron") %>% addMarkers(
  ~Longitude, 
  ~Latitude, 
  popup = ~as.character(Description),
  clusterOptions = markerClusterOptions()
)

# Plot a pallete map 
pal <- colorFactor(c("navy", "red", "green", "blue", "orange", "purple"), domain = c("1", "2", "3", "4", "5", "18"))
leaflet(data = crimes[1:100,]) %>% addTiles() %>% addCircleMarkers(
    ~Longitude, 
    ~Latitude,     
    popup = ~as.character(Description),
    radius = crimes$Precinct,
    color = ~pal(Precinct),
    stroke = FALSE, 
    fillOpacity = 0.5
)
