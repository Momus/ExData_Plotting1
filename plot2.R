## Please see plot1.R for explanation of how data frame is created

columns <- c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

#This function is needed to read the dates correctly.
myDate <- function(from) as.Date(from, format="%d/%m/%Y")

test_data <- subset(read.table(unz("./inst/extdata/household_power_consumption.zip", "household_power_consumption.txt"),  header=T, sep = ";", colClasses = columns, na.strings = "?"), (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Combine Date and Time into one Date object needed for some of the graphs:
test_data$DateTime <- as.POSIXct(paste(test_data$Date, test_data$Time))

## 2. (No Title)
## Line
## x (no label) Date
## y="Global Active Power (kilowatts)"
## x scale "Thu Fri Sat" (Default)
## y scale 0--6 (Default)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(test_data$DateTime, test_data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
