## Load data.table library
library(data.table)

## Read in assignment data as a data table
## Supress warning messages about coercing
powerData <- suppressWarnings(fread("household_power_consumption.txt", 
        sep = ";", na.strings = "?"))

## Set Date column as Date class
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

## Create a new column "datetime" with the Data & Time combined
dataByDate <- within(dataByDate, { datetime=format(paste(dataByDate$Date, 
        dataByDate$Time)) })

## Convert datetime column to POSIXct
dataByDate <- dataByDate[, datetime:=as.POSIXct(datetime)]

## Create png file
png("plot2.png", height = 480, width = 480)

## Plot line graph
with(dataByDate, plot(dataByDate$datetime, dataByDate$Global_active_power, 
        type = "l", xlab="", ylab = "Global Active Power (kilowatts)"))

## Close png graphics device
dev.off()
