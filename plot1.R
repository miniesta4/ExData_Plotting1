plot1 <- function(){
  ## Load library
  library(data.table)
  
  # File to read in working directory.
  
  ## Read header
  header <- fread("./household_power_consumption.txt", nrows = 1, header = FALSE)

  ## Read dataset dates 1/2/2007, 2/2/2007
  hpc <- fread("grep ^[1-2]/2/2007 ./household_power_consumption.txt", header = FALSE, na.strings = "?")

  ## Set vars names from header
  setnames(hpc, as.character(header))

  ## Devise plot
  png(file = "plot1.png")
  hist(hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
}

