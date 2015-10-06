
##Downloading Dataset from Website
if(!file.exists("exdata-data-household_power_consumption.zip")) {
      temp <- tempfile()
      download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
      file <- unzip(temp)
      unlink(temp)
}

##Reading All Data
data_full <- read.table(file, header=T, sep=";")

##Formatting Date and Filtering for relevant dates
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

df <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

##Formatting Rest of Variables In Advance
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)))
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))


####PLOT 3
with(df, {
      plot(Sub_metering_1~timestamp, type="l",
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~timestamp,col='Red')
      lines(Sub_metering_3~timestamp,col='Blue')
})
       
       legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), bty="n", cex=.5)


dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

