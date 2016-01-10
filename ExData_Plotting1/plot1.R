#Read few rows of data in to variable my_data to read column names
my_data <- read.csv("C:/Users/Sneh/Documents/Data Science
                    /Coursera/ExploratoryData/household_power_consumption.txt",
                    nrows=10, sep=";")
#Read column names
col_names <- names(my_data)

#Limited RAM, hence skip unwanted data rows to data for Feb 1st and 2nd 2007 only
my_data <- read.csv("C:/Users/Sneh/Documents/Data Science
                    /Coursera/ExploratoryData/household_power_consumption.txt",
                    skip=60000,nrows=20000, header=TRUE, sep=";", 
                    colClasses = "character")

#Apply column names to read data
names(my_data) <- col_names

#
#my_data$Date <- as.Date(my_data$Date, format="%d/%m/%Y")
DateAndTime <- strptime(paste(my_data$Date,my_data$Time), format="%Y-%m-%d %H:%M:%S")

my_data <- cbind(DateAndTime, my_data)
my_data <- rbind(subset(my_data, Date=="2007-02-01"),
                 subset(my_data, Date=="2007-02-02"))

my_data$Global_active_power <- as.numeric(my_data$Global_active_power)
my_data$Global_reactive_power <- as.numeric(my_data$Global_reactive_power)
my_data$Voltage <- as.numeric(my_data$Voltage)
my_data$Global_intensity <- as.numeric(my_data$Global_intensity)
my_data$Sub_metering_1 <- as.numeric(my_data$Sub_metering_1)
my_data$Sub_metering_2 <- as.numeric(my_data$Sub_metering_2)
my_data$Sub_metering_3 <- as.numeric(my_data$Sub_metering_3)

png("plot1.png", width=480, height=480, units="px")
hist(my_data$Global_active_power, col="red", 
     main="Global Active Power", ylab="Frequency", 
     xlab="Global Active Power (kilowatts)")
dev.off()

png("plot2.png", width=480, height=480, units="px")
plot(x=my_data$DateAndTime ,y=my_data$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

png("plot3.png", width=480, height=480, units="px")
plot(x=my_data$DateAndTime ,y=my_data$Sub_metering_1, 
     type="l", ylab="Energy Sub Metering", xlab="")
lines(x=my_data$DateAndTime ,y=my_data$Sub_metering_2, col="red")
lines(x=my_data$DateAndTime ,y=my_data$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col=c("black","red","blue"))
dev.off()

png("plot4.png", width=480, height=480, units="px")

par(mfcol=c(2,2))

plot(x=my_data$DateAndTime ,y=my_data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

plot(x=my_data$DateAndTime ,y=my_data$Sub_metering_1, 
     type="l", ylab="Energy Sub Metering", xlab="")
lines(x=my_data$DateAndTime ,y=my_data$Sub_metering_2, col="red")
lines(x=my_data$DateAndTime ,y=my_data$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col=c("black","red","blue"), bty="n")

plot(x=my_data$DateAndTime ,y=my_data$Voltage, type="l", ylab="Voltage", 
     xlab="datetime")

plot(x=my_data$DateAndTime ,y=my_data$Global_reactive_power, type="l", 
     ylab="Global Reactive Power", xlab="datetime")

dev.off()