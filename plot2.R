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
  png(filename = "plot2.png", width=480, height=480, units="px")

  ## Create plot and send to file
  with(energy, plot(Global_active_power~Date.Time, 
                    type="l", ylab="Global Active Power (kilowatts)", 
                    xlab=""))

  ## Close PNG device
  dev.off()