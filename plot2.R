plot2 <- function(){
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
  png(file = "plot2.png")
  with(hpc, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
  dev.off()
}

