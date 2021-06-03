## Load packages

library(dplyr)
library(lubridate)

## Read Raw Data File

energy <- read.table("./RawData/household_power_consumption.txt", header = TRUE, 
                     sep=";", na.strings="?")

## Create Date/Time Field and Subset data
energy <- energy %>%
          mutate(Date.Time = parse_date_time(paste(Date, Time, sep=" "),"dmy HMS")) %>%
          select(-Date, -Time) %>%
          subset(Date.Time >= as.Date("2007-2-1") & Date.Time < as.Date("2007-2-3"))

## Create Graph

  ## Open PNG device and Create 'plot1.png' in working directory
  png(filename = "plot1.png", width=480, height=480, units="px")

  ## Create plot and send to file
  hist(energy$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

  ## Close PNG device
  dev.off()