temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
unlink(temp)


DATE1 <- as.Date("01/02/2007", format="%d/%m/%Y")
DATE2 <- as.Date("02/02/2007",format="%d/%m/%Y")

data$DateTime=paste(data$Date, data$Time)
data$DateTime = as.POSIXlt(data$DateTime,format="%d/%m/%Y %H:%M:%S")

mydata<-subset(data,(DateTime<=DATE2)&(DateTime>=DATE1))

png(file="plot2.png", width = 480, height = 480, units = "px")
plot(x=mydata$DateTime,y=mydata$Global_active_power,type = "l",xaxt="n", xlab=NA,ylab="Global Active Power (kilowatts)")
axis.POSIXct(1, at=seq(DATE1, DATE2, by="day"), format="%a")
dev.off()