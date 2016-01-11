## This program reads household_power_consumption.txt file to a data frame and 
## plots the Global Active Power Histogram

# Set working directory to folder where household_power_consumption.txt resides.
setwd("D:/Coursera/ExploratoryData")

# Read few rows of data in to variable pow_consumption to read column names
pow_consumption <- read.csv("household_power_consumption.txt",nrows=10, sep=";")


# Read column names
col_names <- names(pow_consumption)

# Limited RAM, hence skip unwanted data rows
pow_consumption <- read.csv("household_power_consumption.txt",skip=60000,nrows=20000, header=TRUE, sep=";",colClasses = "character")

# Apply column names to read data
names(pow_consumption) <- col_names

# Convert Date Time columns from character to POSIXct and POSIXt 
# and embed to data frame
DateAndTime <- strptime(paste(pow_consumption$Date,pow_consumption$Time), format="%d/%m/%Y %H:%M:%S")
pow_consumption <- cbind(DateAndTime, pow_consumption)

# Tidy data. Subset data from required dates
pow_consumption <- rbind(subset(pow_consumption, Date=="1/2/2007"),subset(pow_consumption, Date=="2/2/2007"))

# Convert columns to numeric
pow_consumption[,4:10] <- sapply(pow_consumption[,4:10],as.numeric)

# Plot 4

# Initiate PNG Device, plot graph and close device
png("plot4.png", width=480, height=480, units="px")

# Create plot matrix
par(mfcol=c(2,2))

# 1
plot(x=pow_consumption$DateAndTime ,y=pow_consumption$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# 2
plot(x=pow_consumption$DateAndTime ,y=pow_consumption$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="")
lines(x=pow_consumption$DateAndTime ,y=pow_consumption$Sub_metering_2, col="red")
lines(x=pow_consumption$DateAndTime ,y=pow_consumption$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black","red","blue"), bty="n")

# 3
plot(x=pow_consumption$DateAndTime ,y=pow_consumption$Voltage, type="l", ylab="Voltage", xlab="datetime")

# 4
plot(x=pow_consumption$DateAndTime ,y=pow_consumption$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="datetime")

dev.off()