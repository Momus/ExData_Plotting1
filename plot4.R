## Please see plot1.R for explanation of how data frame is created

columns <- c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

#This function is needed to read the dates correctly.
myDate <- function(from) as.Date(from, format="%d/%m/%Y")

test_data <- subset(read.table(unz("./inst/extdata/household_power_consumption.zip", "household_power_consumption.txt"),  header=T, sep = ";", colClasses = columns, na.strings = "?"), (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Combine Date and Time into one Date object needed for some of the graphs:
test_data$DateTime <- as.POSIXct(paste(test_data$Date, test_data$Time))

## Four plots on one device.

png(filename = "plot4.png", width = 480, height = 480, units = "px")

## set up graphics device to give a 2x2 plot matrix:
par(mfrow=c(2,2))

## plot 1: DateTime vs ylab=Global Active Power
plot(test_data$DateTime, test_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##plot 2: DateTime v Voltage
plot(test_data$DateTime, test_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

##plot 3: Same as plot3.R
plot(test_data$DateTime, test_data$Sub_metering_1, type = "l", xlab="",  ylab="Energy sub metering")
lines(test_data$DateTime, test_data$Sub_metering_2, col="red")
lines(test_data$DateTime, test_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "blue","red"), lty = 1)

##Plot 4: Datetime v Global_reactive_power
plot(test_data$DateTime, test_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
