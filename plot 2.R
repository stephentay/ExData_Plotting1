#Create destination folder for the zip file to be downloaded
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile ="./data/assignment.zip")

##Unzip the file and set new working directory to the folder of the file
unzip("./data/assignment.zip", exdir = "./data")
setwd("./data")

##Read data and subset data to 1/2/2007 and 2/2/2007
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

##Change the class of each column
for(i in c(1:9)) {
	df[,i] <- as.character(df[,i])
}

for(i in c(3:9)) {
	df[,i] <- as.numeric(df[,i])
}

##Load lubridate package and create a POSIXct datetime variable
library(lubridate)
df$datetime <- paste(df$Date, df$Time)
df$datetime <- dmy_hms(df$datetime)

##Plot 2: Time-series of Global Active Power
png(filename = "../plot 2.png", width = 480, height = 480, units ="px")

with(df, plot(datetime, Global_active_power, xlab = NA, ylab = "Global Active Power (kilowatts)", pch = NA))
with(df, lines(datetime, Global_active_power))

dev.off()