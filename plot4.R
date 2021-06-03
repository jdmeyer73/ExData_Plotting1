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
  png(filename = "plot4.png", width=480, height=480, units="px")

  ## Create grid
  par(mfcol=c(2, 2))
  
  
  ## Create plot 1 and send to file
  with(energy, plot(Global_active_power~Date.Time, 
                    type="l", ylab="Global Active Power (kilowatts)", 
                    xlab=""))
  
  ## Create plot 2 and send to file
  with(energy, plot(Sub_metering_1~Date.Time, type="l",
                    ylab="Energy sub metering", 
                    xlab="", col="black"))
  with(energy, points(Sub_metering_2~Date.Time, type="l", col="red"))
  with(energy, points(Sub_metering_3~Date.Time, type="l", col="blue"))
  legend("topright", lty=1, col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  
  ## Create plot 3 and send to file
  with(energy, plot(Voltage~Date.Time, 
                    type="l", ylab="Voltage", 
                    xlab="datetime"))
  
  ## Create plot 4 and send to file
  with(energy, plot(Global_reactive_power~Date.Time, 
                    type="l",  
                    xlab="datetime"))

  ## Close PNG device
  dev.off()