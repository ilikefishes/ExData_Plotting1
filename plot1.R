## Load data.table library
library(data.table)

## Read in assignment data as a data table
powerData <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

## Set Date column as Date objects
powerData <- powerData[, Date:=as.Date(Date,format="%d/%m/%Y")]

## Set Global Active Power column as numeric
powerData <- powerData[, Global_active_power:=as.numeric(Global_active_power)]

## Set minimum and maximum date for subsetting
minDate <- as.Date("2007-02-01")
maxDate <- as.Date("2007-02-02")

## Subset data by dates required for assignment
dataByDate <- powerData[Date >= minDate & Date <= maxDate]

## Remove large data table for optimization
rm(powerData)

## Create png file
png("plot1.png", height = 480, width = 480)

## Plot histograph
hist(dataByDate$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Close png graphics device
dev.off()
