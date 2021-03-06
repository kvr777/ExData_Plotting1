temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
unlink(temp)


DATE1 <- as.POSIXct("01/02/2007", format="%d/%m/%Y")
DATE2 <- as.POSIXct("03/02/2007",format="%d/%m/%Y")

data$DateTime=paste(data$Date, data$Time)
data$DateTime = as.POSIXlt(data$DateTime,format="%d/%m/%Y %H:%M:%S")

mydata<-subset(data,(DateTime<DATE2)&(DateTime>=DATE1))

png(file="plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))

#plot left-top graph
plot(x=mydata$DateTime,y=mydata$Global_active_power,type = "l",xaxt="n", xlab=NA,ylab="Global Active Power")
axis.POSIXct(1, at=seq(DATE1, DATE2, by="day"), format="%a")

#plot left-bottom graph
plot(x=mydata$DateTime,y=mydata$Sub_metering_1,type = "l",xaxt="n", xlab=NA,ylab="Energy sub metering")
lines(x=mydata$DateTime, mydata$Sub_metering_2, col="red")
lines(x=mydata$DateTime, mydata$Sub_metering_3, col="blue")

axis.POSIXct(1, at=seq(DATE1, DATE2, by="day"), format="%a")


legend("topright", 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), 
       lty=c(1, 1, 1))

#plot right-top graph

plot(x=mydata$DateTime,y=mydata$Voltage,type = "l",xaxt="n", xlab="datetime",ylab="Voltage")
axis.POSIXct(1, at=seq(DATE1, DATE2, by="day"), format="%a")

#plot right-bottom graph
plot(x=mydata$DateTime,y=mydata$Global_reactive_power,type = "l",xaxt="n", xlab="datetime",ylab="Global_reactive_power")
axis.POSIXct(1, at=seq(DATE1, DATE2, by="day"), format="%a")

dev.off()