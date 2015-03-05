plot4 <- function(){
  # Vars classes
  classes <- c(rep("character", 2), rep("numeric", 7))

  ## Read header
  header <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)

  ## Read dataset dates 1/2/2007, 2/2/2007
  hpc <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", colClasses = classes, skip = 66637, nrows = 2880, stringsAsFactors = FALSE)

  ## Set vars names from header
  names(hpc) <- header

  ## Add date/time var
  dt <- paste(hpc$Date, hpc$Time)
  hpc$datetime <- strptime(dt, "%d/%m/%Y %H:%M:%S")
  
  ## Devise plot
  ## Open file device
  png(file = "plot4.png")
  
  ## Layout
  par(mfcol = c(2, 2))
  
  ## Plots
  with(hpc, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

  with(hpc, plot(datetime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
  with(hpc, lines(datetime, Sub_metering_2, col = "red"))
  with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lw = 0)

  with(hpc, plot(datetime, Voltage, type="l"))

  with(hpc, plot(datetime, Global_reactive_power, type="l"))
  
  ## Close file device
  dev.off()
}

