

   my_data <- read.csv("household_power_consumption.txt", sep=";",colClasses="character")
   my_data <- my_data[1:100000,]
   good_data <- my_data
   good_data[,1] <- as.Date(good_data[,1], "%d/%m/%Y")
  
   subset_data1 <- subset(good_data,good_data$Date=="2007-02-01")
   subset_data2 <- subset(good_data,good_data$Date=="2007-02-02")
   subset_data <- subset_data1
   subset_data[1441:2880,] <- subset_data2
   
   temp <-paste(subset_data[,1], subset_data[,2])
   subset_data[,1] <- temp
   
   temp <- strptime(subset_data[,1] , "%Y-%m-%d %H:%M:%S")
   subset_data$Date <- temp
   
   png(file = "plot3.png", width = 480, height = 480)
   plot(x = subset_data$Date , y = as.numeric(subset_data[,7]), type = "l" , xlab = "", ylab = "Energy sub metering")
   points(x = subset_data$Date , y = as.numeric(subset_data[,8]), col = "red", type = "l")
   points(x = subset_data$Date , y = as.numeric(subset_data[,9]), col = "blue", type = "l")
   legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), 
   lwd=c(2.5,2.5), col=c("black","red","blue"), y.intersp = 1, xjust = 0.5)
   
   dev.off()
   
   