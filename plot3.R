## Load data.table library
library(data.table)

## Read in assignment data as a data table
powerData <- suppressWarnings(fread("household_power_consumption.txt", sep = ";", na.strings = "?"))

## Set Date column as Date objects
powerData <- powerData[, Date:=as.Date(Date,format="%d/%m/%Y")]

## Set Global Active Power column as numeric
powerData <- powerData[, Global_active_power:=as.numeric(Global_active_power)]
powerData <- powerData[, Sub_metering_1:=as.numeric(Sub_metering_1)]
powerData <- powerData[, Sub_metering_2:=as.numeric(Sub_metering_2)]

## Set minimum and maximum date for subsetting
minDate <- as.Date("2007-02-01")
maxDate <- as.Date("2007-02-02")

## Subset data by dates required for assignment
dataByDate <- powerData[Date >= minDate & Date <= maxDate]

## Remove large data table for optimization
rm(powerData)

## Create a new column "datetime" with the Data & Time combined
dataByDate <- within(dataByDate, { datetime=format(paste(dataByDate$Date, dataByDate$Time)) })

## Convert datetime column to POSIXct
dataByDate <- dataByDate[, datetime:=as.POSIXct(datetime)]


## Create png file
png("plot3.png", height = 480, width = 480)

## Plot line graphs
with(dataByDate, plot(dataByDate$datetime, dataByDate$Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering", col = "black"))
with(dataByDate, lines(dataByDate$datetime, dataByDate$Sub_metering_2, col = "red"))
with(dataByDate, lines(dataByDate$datetime, dataByDate$Sub_metering_3, col = "blue"))

## Plot legend
legend("topright", col = c("black", "red", "blue"),lty = c(1, 1, 1), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close png graphics device
dev.off()


