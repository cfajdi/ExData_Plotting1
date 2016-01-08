## set working directory

## check file structure within folder/subfolders
list.files(recursive = TRUE)

## load sqldf library
library(sqldf)

## read filtered data into file using SQL - 
epcdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file 
where Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## close file connection
close(file("household_power_consumption.txt"))

## convert the Date and Time variables to Date/Time classes
epcdata$DT <- strptime(paste(epcdata$Date, epcdata$Time), "%d/%m/%Y %H:%M:%S")
## epcdata$Date <-  as.Date(epcdata$Date, "%d/%m/%Y")
## epcdata$Time <-  strptime(epcdata$Time, "%H:%M:%S")
## as.numeric(as.character(epcdata$Global_active_power))

## check default parameter
par()

## set graphic device type and size as 480x480
png(
      filename = "plot1.png",
      width = 480,
      height = 480
)

## construct histogram
hist(
      epcdata$Global_active_power,
      breaks = 16, 
      main = "Global Active Power",
      xlab="Global Active Power (kilowatts)",
      col="red"
##      ylim = c(0, 1200), 
##      xlim = c(0, 6)
)

## close dev
dev.off()
