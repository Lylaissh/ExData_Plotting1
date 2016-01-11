

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
   
   png(file = "plot1.png", width = 480, height = 480)
   hist(as.numeric(subset_data[,3]), col = "red" , xlab = "Global Acive Power (kilowatts) ", main="Global Active Power")
   dev.off()
   
   