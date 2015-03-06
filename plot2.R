plot2 <- function(){
  ## File to read in working directory.
  
  ## Read header
  header <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)

  ## Read dataset dates 1/2/2007, 2/2/2007
  classes <- c(rep("character", 2), rep("numeric", 7))
  hpc <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", colClasses = classes, skip = 66637, nrows = 2880, stringsAsFactors = FALSE)

  ## Set vars names from header
  names(hpc) <- header

  ## Add date/time var
  dt <- paste(hpc$Date, hpc$Time)
  hpc$datetime <- strptime(dt, "%d/%m/%Y %H:%M:%S")
  
  ## Devise plot
  png(file = "plot2.png")
  with(hpc, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
  dev.off()
}

