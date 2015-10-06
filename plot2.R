
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



####PLOT 2
plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()