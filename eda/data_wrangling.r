# Import R Packages and Modules
library(dplyr)
library(stringr)

# Import our datasets
raw <- read.csv('../data/crimes.csv', header = TRUE, stringsAsFactors = TRUE, na.strings=c("","NA"))

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
crimes <- filter(.data = crimes, Year == "2015")

# Look for cell with the value NA in crime
crimes <- na.omit(crimes)

# Update Month field
crimes$Month[crimes$Month == "01"] <- "Jan"
crimes$Month[crimes$Month == "02"] <- "Feb"
crimes$Month[crimes$Month == "03"] <- "Mar"
crimes$Month[crimes$Month == "04"] <- "Apr"
crimes$Month[crimes$Month == "05"] <- "May"
crimes$Month[crimes$Month == "06"] <- "Jun"
crimes$Month[crimes$Month == "07"] <- "Jul"
crimes$Month[crimes$Month == "08"] <- "Aug"
crimes$Month[crimes$Month == "09"] <- "Sep"
crimes$Month[crimes$Month == "10"] <- "Oct"
crimes$Month[crimes$Month == "11"] <- "Nov"
crimes$Month[crimes$Month == "12"] <- "Dec"

# Re-arrange the columns in crimes_2015
crimes <- select(.data = crimes, Offense, Description, Neighborhood, Precinct, UCRCode, Time, Month, Year, Date, Longitude, Latitude )

# Save crime_2015 as .csv
write.csv(crimes, file = "Crimes.csv")

View(crimes)
