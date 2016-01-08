##
## Third plot

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
## main program
plot3png <- function() {
  dt <- readFile()
  png(file="plot3.png",width=480,height=480)
  plot3(dt)
  dev.off()
}
