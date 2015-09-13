## load function
## http://stackoverflow.com/questions/12460938/r-reading-in-a-zip-data-file-without-unzipping-it
## data <- read.table(unz("Sales.zip", "Sales.dat"), nrows=10, header=T, quote="\"", sep=",")

##What does our data look like?
## list the files contained in the zip archive:
##   system("unzip -l ./inst/extdata/household_power_consumption.zip")

## Archive:  ./inst/extdata/household_power_consumption.zip
##   Length      Date    Time    Name
## ---------  ---------- -----   ----
## 132960755  10-12-2012 05:38   household_power_consumption.text
## ---------                     -------
## 132960755                     1 file

## Only one file.  Look at the top of this file:
## For some reason, piping doesn't work in R system()
## So using a terminal:
## unzip -p household_power_consumption.zip | head -n 30

## /extdata $ unzip -p household_power_consumption.zip | head -n 30
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3

## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

##  16/12/2006; 17:25:00; 5.360;   0.436;   233.630;  23.000;  0.000;  1.000;  16.000

columns <- c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")


#This function is needed to read the dates correctly.
myDate <- function(from) as.Date(from, format="%d/%m/%Y")

## Times will be left as strings: since they are in 24 hour format, they are in chronological order anyway

## add  na.strings = "?" parameter

## only be using data from the dates 2007-02-01 and 2007-02-02.
## subset(test_data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
              
##All together:
test_data <- subset(read.table(unz("./inst/extdata/household_power_consumption.zip", "household_power_consumption.txt"),  header=T, sep = ";", colClasses = columns, na.strings = "?"), (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Combine Date and Time into one Date object needed for some of the graphs:
 test_data$DateTime <- as.POSIXct(paste(test_data$Date, test_data$Time))




## 1. Global Active Power(title)
##  Frequency distribution
##  Histogram
##  x= "Global Active Power (kilowatts)
##  y=  "Frequency"
## x scale 0--6
## y scale 0--1200
## color: red
png(filename = "plot1.png")
hist(test_data$Global_active_power, col="red", xlab = "Global Active Power (kilowats)", main ="Global Active Power")
dev.off()

## 3. (no title)
##  Multi-line
## x (no label) Date
## y="Energy sub metering"
## color: sub1: black; sub2: red; sub3: blue
## x scale "Thu Fri Sat"
## y scale 0--30
png(filename = "plot3.png")
plot(test_data$DateTime, test_data$Sub_metering_1, type = "l", xlab="",  ylab="Energy sub metering")
lines(test_data$DateTime, test_data$Sub_metering_2, col="red")
lines(test_data$DateTime, test_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "blue","red"), lty = 1)
dev.off()

## 4. Four plots


png(filename = "plot2.png")
## set up device to give a 2x2 plot matrix:
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
