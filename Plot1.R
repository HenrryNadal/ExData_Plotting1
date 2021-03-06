
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

png(filename = "plot1.png", width = 480, height = 480)

#Plotting the histogram
hist(Data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")

dev.off()

