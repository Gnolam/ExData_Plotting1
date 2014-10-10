
setwd("D:/Coursera/4. Exploratory Data Analysis (Exdata-004)/Code/Project 1/")

require("sqldf")

# Let's be lazy and peform all filter operations in one line
# Referring here to instruction:
#   We will only be using data from the dates 2007-02-01 and 2007-02-02.
#   One alternative is to read the data from just those dates
#       rather than reading in the entire dataset and subsetting to those dates.

sql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
file <- "./Data/household_power_consumption.txt"
data <- read.csv.sql(file, sql,sep = ";")
closeAllConnections()


data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
rm(datetime)


# Create png file for Plot 3

with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

