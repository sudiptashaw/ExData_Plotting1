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

# Plot 1
attach(data_sub)
hist(data_sub$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Saving to PNG file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()