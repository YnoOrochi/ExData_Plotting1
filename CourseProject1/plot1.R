##
## First plot - Histogram

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
## building the first plot
plot1 <- function(dt=NULL) {
  if (is.null(dt) | !exists("dt")) dt <- readFile()

  hist(
    dt$Global_active_power,
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)"
    )
}

##
## main program
plot1png <- function() {
  dt <- readFile()
  png(file="plot1.png",width=480,height=480)
  plot1(dt)
  dev.off()
}
