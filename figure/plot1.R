temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"),na.strings="?")
unlink(temp)


DATE1 <- as.Date("01/02/2007", format="%d/%m/%Y")
DATE2 <- as.Date("02/02/2007",format="%d/%m/%Y")

data$DateParced = as.Date(data$Date,format="%d/%m/%Y")

mydata<-subset(data,(DateParced<=DATE2)&(DateParced>=DATE1))

png(file="plot1.png", width = 480, height = 480, units = "px")
hist(mydata$Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

