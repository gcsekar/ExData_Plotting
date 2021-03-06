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
attach(powerdata)
hist(Global_active_power, col='red', xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

##save as PNG files
dev.copy(png, file="Plot1.png",width=480, height=480)
dev.off()
