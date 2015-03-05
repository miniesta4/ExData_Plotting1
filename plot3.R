plot3 <- function(){
  # vars classes
  classes <- c(rep("character", 2), rep("numeric", 7))

  ## read header
  header <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)

  ## read dataset dates 1/2/2007, 2/2/2007
  hpc <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", colClasses = classes, skip = 66637, nrows = 2880, stringsAsFactors = FALSE)

  ## set vars names from header
  names(hpc) <- header

  ## add date/time var
  dt <- paste(hpc$Date, hpc$Time)
  hpc$datetime <- strptime(dt, "%d/%m/%Y %H:%M:%S")
  
  ## devise plot
  png(file = "plot3.png")
  with(hpc, plot(datetime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
  with(hpc, lines(datetime, Sub_metering_2, col = "red"))
  with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

