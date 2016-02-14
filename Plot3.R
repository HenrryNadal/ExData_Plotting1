
library(lubridate)


temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")
contain<-unz(temp, "household_power_consumption.txt")


Data<-read.table(contain, sep=";", header = T, stringsAsFactors = FALSE, na.strings = "?")
Data$DateTime<-paste(Data$Date,Data$Time)
Data$DateTime<-strptime(Data$DateTime, "%d/%m/%Y %H:%M:%S")
Data$Date<-as.Date(Data$Date, "%d/%m/%Y")
Data$Time<-hms(Data$Time)
Data<-subset(Data, "2007-02-01"<=Date  & Date<="2007-02-02")



png(filename = "plot3.png", width = 480, height = 480)

#Plotting Energy submetering 1-3 vs DateTime
with(Data, plot(DateTime,Sub_metering_1, "l", xlab="", 
                ylab="Energy sub metering"))
lines(Data$DateTime, Data$Sub_metering_2, col="red")
lines(Data$DateTime, Data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)


dev.off()