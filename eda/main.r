# Import R Packages and Modules
library("dplyr")
library(stringr)

# Import our datasets
raw <- read.csv('../data/crimes.csv', header = TRUE, stringsAsFactors = TRUE)

# Using the Select function - Select some particular field from the raw data
crimes <- select(.data = raw, Offense, Description, Neighborhood, Precinct, UCRCode, Time, ReportedDate, Long, Lat )

# Change some specific column names in the crimes data
colnames(crimes)[which(names(crimes) == "ReportedDate")] <- "Date"
colnames(crimes)[which(names(crimes) == "Long")] <- "Longitude"
colnames(crimes)[which(names(crimes) == "Lat")] <- "Latitude"

# Derive Year & Month of the crime from timestamp
crimes$Date <- str_split_fixed(as.character(crimes$Date), "T", 2)[,1]
crimes$Year <- format(as.Date(crimes$Date, format="%Y-%m-%d"),"%Y")
crimes$Month <- format(as.Date(crimes$Date, format="%Y-%m-%d"),"%m")

# Query for only records for 2015
crimes_2015 <- filter(.data = crimes, Year == "2015")

# Look for cell with the value NA in crime_2015
crimes_2015 <- na.omit(crimes_2015)

# Re-arrange the columns in crimes_2015
crimes_2015 <- select(.data = crimes_2015, Offense, Description, Neighborhood, Precinct, UCRCode, Time, Month, Year, Date, Longitude, Latitude )

# Save crime_2015 as .csv
write.csv(crimes_2015, file = "Crimes_2015.csv")