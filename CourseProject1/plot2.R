##
## Second plot

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
## main program
plot2png <- function() {
  dt <- readFile()
  png(file="plot2.png",width=480,height=480)
  plot2(dt)
  dev.off()
}
