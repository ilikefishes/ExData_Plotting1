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
png(filename = "plot4.png", width = 480, height = 480)

## Change param to allow multiple plots
par(mfrow = c(2,2))

## Plot 1st 
with(dataByDate, plot(dataByDate$datetime, dataByDate$Global_active_power, 
        type = "l", xlab="", ylab = "Global Active Power"))

## Plot 2nd
with(dataByDate, plot(dataByDate$datetime, dataByDate$Voltage, type = "l", 
        xlab = "datetime", ylab = "Voltage"))

## Plot 3rd
with(dataByDate, plot(dataByDate$datetime, dataByDate$Sub_metering_1, 
        type = "l", xlab = "", ylab="Energy sub metering", col = "black"))
with(dataByDate, lines(dataByDate$datetime, dataByDate$Sub_metering_2, 
        col = "red"))
with(dataByDate, lines(dataByDate$datetime, dataByDate$Sub_metering_3, 
        col = "blue"))
legend("topright", bty = "n", col = c("black", "red", "blue"),lty = c(1, 1, 1), 
        lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4th
with(dataByDate, plot(dataByDate$datetime, dataByDate$Global_reactive_power, 
        type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

## Close png graphics device
dev.off()
