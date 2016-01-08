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
      filename = "plot4.png",
      width = 480,
      height = 480
)

## create 4 chart panel
par(mfrow=c(2,2))

## construct top left plot
plot(
      epcdata$DT, 
      epcdata$Global_active_power,
      ylab="Global Active Power (kilowatts)",
      xlab="",
      type = "l"
)

## construct top right plot
plot(
      epcdata$DT, 
      epcdata$Voltage,
      ylab="Voltage",
      xlab="datetime",
      type = "l"
)

## construct bottom left plot
## construct line plot
plot(
      epcdata$DT, 
      epcdata$Sub_metering_1,
      ##    main = "Global Active Power",
      ylab="Energy sub metering",
      xlab="",
      type = "l",
      col="black"
      ##    ylim = c(0, 1200), 
      ##    xlim = c(0, 6)
)

## add 2nd line plot
lines(
      epcdata$DT, 
      epcdata$Sub_metering_2,
      col = "red"
)

## add 3rd line plot
lines(
      epcdata$DT, 
      epcdata$Sub_metering_3,
      col = "blue"
)

## add legend to graph
legend(
      "topright", 
      col=c("black", "red", "blue"), 
      legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      lty=1, 
      lwd=2,
      bty="n",
      cex = 0.8
)

## construct bottom right plot
plot(
      epcdata$DT, 
      epcdata$Global_reactive_power,
      ylab="",
      xlab="datetime",
      type = "l"
      
)


## reset par and close dev
par(mfrow=c(1,1))
dev.off()
