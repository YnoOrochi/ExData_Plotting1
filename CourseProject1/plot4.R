##
## Fourth plot - par(2,2)

##
## obs. I assume that unzip the file is not part of the assignment.
## the file is unziped at local dir: household_power_consumption.txt

##
## Read the file and save only the 1/2/2007 and 2/2/2007 lines.
library(data.table)
readFile <- function() {
  fread("household_power_consumption.txt", na.strings="?")[Date=="1/2/2007" | Date=="2/2/2007",]
}

##
## building the second plot
plot2 <- function(dt=NULL, hr=NULL, tt="Global Active Power (kilowatts)") {
  if (is.null(dt) | !exists("dt")) dt <- readFile()

  ## creates a time vector a single time when called by plot4
  if (is.null(hr)) hr <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")

  plot(hr, dt$Global_active_power, type="l", xlab="", ylab=tt)
}

##
## building the third plot
plot3 <- function(dt=NULL, hr=NULL, bt="o") {
  if (is.null(dt) | !exists("dt")) dt <- readFile()

  ## creates a time vector a single time when called by plot4
  if (is.null(hr)) hr <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")

  ## plot the main graphic using sub...1
  plot(hr, dt$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

  ## plots sub...2 and sub...3 points
  points(hr, dt$Sub_metering_2, type="l", col="red")
  points(hr, dt$Sub_metering_3, type="l", col="blue")

  ## plots the legends
  legend(
    "topright",
    lty=1,
    bty=bt,
    col=c("black", "red", "blue"),
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    )
}

##
## building the fourth plot
plot4 <- function(dt=NULL) {
  if (is.null(dt) | !exists("dt")) dt <- readFile()

  ## creates a time vector a single time
  hr <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")

  ## divide the graphics in 2x2 space
  par(mfrow=c(2,2), mex=0.6)

  ## plots the four graphics
  plot2(dt, hr, "Global Active Power")
  plot(hr, dt$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot3(dt, hr, "n")
  plot(hr, dt$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}

##
## main program
plot4png <- function() {
  dt <- readFile()
  png(file="plot4.png",width=480,height=480)
  plot4(dt)
  dev.off()
}
