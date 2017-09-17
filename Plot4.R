# Download the file and put the file in the working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Data.zip",method="curl")

# Unzip the file
unzip(zipfile="./Data.zip")

# Read Data
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Converting to Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset the data
data_sub <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
data_sub$datetime <- strptime(paste(data_sub$Date, data_sub$Time), "%Y-%m-%d %H:%M:%S")
data_sub$datetime <- as.POSIXct(data_sub$datetime)

# Setting graphic device to PNG file
png(filename = "plot4.png", width = 480, height = 480)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_sub, {
        plot(Global_active_power~datetime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~datetime, type="l", 
             ylab="Voltage", xlab="")
        plot(Sub_metering_1~datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~datetime, type="l", 
             ylab="Global_reactive_power",xlab="")
})

dev.off()