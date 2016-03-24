library(magrittr)
library(reshape2)

epcsubset <- read.csv("household_power_consumption.txt",sep = ";",stringsAsFactors=FALSE) %>% 
              subset(as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01","%Y-%m-%d")| 
                     as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02","%Y-%m-%d")) 

epcplot4 <- epcsubset[, c("Date","Time","Global_active_power",
                          "Global_reactive_power",
                          "Voltage",
                          "Sub_metering_1","Sub_metering_2","Sub_metering_3")]

ecpdatetimes <- strptime(paste(epcplot4$Date,epcplot4$Time," "),"%d/%m/%Y %H:%M:%S") %>% cbind(epcplot4)
colnames(ecpdatetimes)[1] <- c("datetime")

ecpMelt <- melt(ecpdatetimes, id=c("datetime"),measure.vars = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
colnames(ecpMelt)[2] <- "metering"

par(mfrow = c(2, 2),mar = c(4, 4, 2, 1))
with(ecpdatetimes, {
  plot(datetime,as.numeric(as.character(Global_active_power)),
       ylab = "Global Active Power(killowatts)", xlab= "", type = "n")
  lines(datetime,as.numeric(as.character(Global_active_power)), type = "S")
  
  plot(datetime,as.numeric(as.character(Voltage)),ylab = "Voltage", xlab= "datetime", type = "n")
  lines(datetime,as.numeric(as.character(Voltage)), type = "S")
  
  with(ecpMelt, plot(ecpMelt$datetime,ecpMelt$value,ylab="Energy sub metering", xlab="",type = "n"))
  with(subset(ecpMelt,metering == "Sub_metering_1"),lines(datetime,value,col = "black"))
  with(subset(ecpMelt,metering == "Sub_metering_2"),lines(datetime,value,col = "red"))
  with(subset(ecpMelt,metering == "Sub_metering_3"),lines(datetime,value,col = "blue"))
  legend("topright", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(datetime,as.numeric(as.character(Global_reactive_power)), ylab = "Global_reactive_power", xlab= "datetime",type ="n")
  lines(datetime,as.numeric(as.character(Global_reactive_power)), type = "S")

})

dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the file

