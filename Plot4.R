
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




##Putting 4 plots in a graph
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar=c(6,5,1,1), oma=c(0,0,1,1))

with(Data, plot(DateTime, Global_active_power, "l", xlab="",ylab="Global Active Power (kilowatts)"))

with(Data,plot(DateTime, Voltage, "l" ))

with(Data, plot(DateTime,Sub_metering_1, "l", xlab="",ylab="Energy sub metering"))
lines(Data$DateTime, Data$Sub_metering_2, col="red")
lines(Data$DateTime, Data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n")

with(Data, plot(DateTime, Global_reactive_power, "l",))



dev.off()



