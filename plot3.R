#setting working directory
setwd("D:/R/wd")
#reading the file
household_power_consumption <- read.csv("D:/R/wd/household_power_consumption.txt", sep=";", na.strings="?",stringsAsFactors = FALSE)
#putting date and time together
household_power_consumption$DateTime <-paste(household_power_consumption$Date, household_power_consumption$Time)
#normalizing the time so R can understand it
household_power_consumption$DateTime <- as.POSIXct(strptime(household_power_consumption$DateTime, "%d/%m/%Y %H:%M:%S"))
#need to normalize date too in order to subset it
household_power_consumption$Date <- as.POSIXct(strptime(household_power_consumption$Date, "%d/%m/%Y"))
#subsetting the data
myData <- subset(household_power_consumption, household_power_consumption$Date == "2007-02-01 CET" | household_power_consumption$Date =="2007-02-02")
#actual plot with graphic device usage
install.packages("ggplot2")
library(datasets)
library(ggplot2)
with(myData, plot(myData$DateTime,myData$Sub_metering_1,type="l", pch=NA, col="black", xlab=NA, ylab="Energy sub metering")) 
with(myData, lines(myData$DateTime,myData$Sub_metering_2, type="l",col="red"))
with(myData, lines(myData$DateTime, myData$Sub_metering_3,type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", width=480, height=480, units="px")  
dev.off()  