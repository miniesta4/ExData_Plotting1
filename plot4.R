plot4 <- function(){
  ## Load library
  library(data.table)
  
  # File to read in working directory.
  
  ## Read header
  header <- fread("./household_power_consumption.txt", nrows = 1, header = FALSE)
  
  ## Read dataset dates 1/2/2007, 2/2/2007
  hpc <- fread("grep ^[1-2]/2/2007 ./household_power_consumption.txt", header = FALSE, na.strings = "?")
  
  ## Set vars names from header
  setnames(hpc, as.character(header))
  
  ## Add date/time var
  Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")
  dt <- paste(hpc[, Date], hpc[, Time])
  dt_t <- as.POSIXct(strptime(dt, "%d/%m/%Y %H:%M:%S"))
  hpc[, datetime := dt_t]
  
  ## Devise plot
  ## Open file device
  png(file = "plot4.png")
  
  ## Layout
  par(mfcol = c(2, 2))
  
  ## Plots
  with(hpc, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

  with(hpc, {
    plot(datetime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
  })
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lw = 0)
  
  with(hpc, plot(datetime, Voltage, type="l"))

  with(hpc, plot(datetime, Global_reactive_power, type="l"))
  
  ## Close file device
  dev.off()
}

