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

##Plot 4: Two-by-two Panel plots
png(filename = "../plot 4.png", width = 480, height = 480, units ="px")
par(mfcol = c(2,2), cex = 0.8)

### Plot A: Time-series of Global Active Power
with(df, plot(datetime, Global_active_power, xlab = NA, ylab = "Global Active Power", pch = NA))
with(df, lines(datetime, Global_active_power))

### Plot B: Time-series of Sub-metering 1, 2 and 3
with(df, plot(datetime, Sub_metering_1, xlab = NA, ylab = "Energy sub metering", pch = NA))
with(df, lines(datetime, Sub_metering_1))

with(df, points(datetime, Sub_metering_2, pch = NA))
with(df, lines(datetime, Sub_metering_2, col = "red"))

with(df, points(datetime, Sub_metering_3, pch = NA))
with(df, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), box.lwd = 0, legend = names(df[,c(7:9)]))

### Plot C: Time-series of Voltage
with(df, plot(datetime, Voltage, pch = NA))
with(df, lines(datetime, Voltage))

### Plot D: Time-series of Global Reactive Power
with(df, plot(datetime, Global_reactive_power, pch = NA))
with(df, lines(datetime, Global_reactive_power))

dev.off()