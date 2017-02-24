library(dplyr)

#Read the data
powerdata <- read.delim("data/household_power_consumption.txt", sep = ";", header = TRUE,na.strings = "?" )
powerdata <- powerdata[complete.cases(powerdata),]
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")

powerdata <- tbl_df(powerdata)
powerdata <- filter(powerdata, Date >= '2007-02-01' & Date <= '2007-02-02')

dateTime <- paste(powerdata$Date, powerdata$Time)
dateTime <- setNames(dateTime, "DateTime")

powerdata <- select(powerdata, -c(Date, Time))
powerdata <- cbind(dateTime, powerdata)
powerdata$dateTime <- as.POSIXct(dateTime)

## Plot graph

plot(powerdata$Sub_metering_1 ~ powerdata$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(powerdata$Sub_metering_2 ~ powerdata$dateTime, col='red')
lines(powerdata$Sub_metering_3 ~ powerdata$dateTime, col='blue')
legend("topright", c("Sub metering 1","Sub metering 2","Sub metering 3"), col=c('black','red','blue'), lwd = 1)

##save as PNG files
dev.copy(png, file="Plot3.png",width=480, height=480)
dev.off()
