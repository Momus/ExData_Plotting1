## Please see plot1.R for explanation of how data frame is created

columns <- c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

#This function is needed to read the dates correctly.
myDate <- function(from) as.Date(from, format="%d/%m/%Y")

test_data <- subset(read.table(unz("./inst/extdata/household_power_consumption.zip", "household_power_consumption.txt"),  header=T, sep = ";", colClasses = columns, na.strings = "?"), (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Combine Date and Time into one Date object needed for some of the graphs:
test_data$DateTime <- as.POSIXct(paste(test_data$Date, test_data$Time))

## 3. (no title)
##  Multi-line
## x (no label) Date
## y="Energy sub metering"
## color: sub1: black; sub2: red; sub3: blue
## x scale "Thu Fri Sat"(Default)
## y scale 0--30 (Default)
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(test_data$DateTime, test_data$Sub_metering_1, type = "l", xlab="",  ylab="Energy sub metering")
lines(test_data$DateTime, test_data$Sub_metering_2, col="red")
lines(test_data$DateTime, test_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "blue","red"), lty = 1)
dev.off()
